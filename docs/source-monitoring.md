# Quellenüberwachung – Stand 21.10.2026

Supabase Edge Function: `check-benefit-sources` (deployed, active).

## Verhalten
- Ruft offizielle HTTPS-Quellen aus `benefit_sources` ab.
- Erlaubte Hosts: bmf.gv.at, oesterreich.gv.at, noel.gv.at, ams.at (inklusive Subdomains).
- Erzeugt SHA-256-Fingerprints aus normalisiertem HTML-Text.
- Schreibt jede Prüfung nach `source_checks` mit Ergebnis `unchanged`, `changed` oder `unavailable`.
- Markiert Änderungen mit `review_required=true`; Förderregeln werden **nicht** automatisch geändert.
- Die erste Prüfung einer Quelle legt nur eine Baseline an.
- Eine HTML-Änderung ist nicht zwingend eine rechtliche Änderung; menschliche fachliche Prüfung nötig.

## Betrieb – noch einzurichten
- Die Function ist mit `verify_jwt=true` geschützt und verlangt zusätzlich den geheimen Header `x-source-check-secret`.
- Vor der ersten Ausführung im Supabase-Dashboard unter **Edge Functions → Secrets** einen starken Zufallswert als `SOURCE_CHECK_SECRET` hinterlegen.
- Den geheimen Wert **niemals** ins Repository oder Browser-JavaScript schreiben.
- Anschließend einen geschützten täglichen Zeitplan (Supabase Cron / Scheduler) für die Function einrichten, mit gültiger Authentifizierung und geheimem Header.
- Noch **keine** erfolgreiche Quellenprüfung und **kein** täglicher Zeitplan bestätigt.

## Grenzen
- Derzeit nur HTML-Seiten von vier Domains, keine PDF-Dokumente oder alle österreichischen Förderstellen.
- Seiten mit dynamischem Inhalt können unvollständig erfasst werden.
- Änderungen in verlinkten PDFs werden nicht erkannt.
- Für produktive Aktualität: robustes Monitoring, Alerts, Quellenausbau, fachlicher Freigabeprozess.

## Täglicher Cron-Zeitplan (angelegt am 21.10.2026)
- `pg_cron` und `pg_net` aktiviert.
- Cron-Job `foerderfinder-daily-source-check`: `15 4 * * *` (04:15 UTC).
- Datenbankfunktion `public.invoke_benefit_source_check()` ruft die Edge Function mit authentifizierten HTTP-Headern auf.
- Sie erwartet **zwei zusätzliche verschlüsselte Vault-Secrets**:
  - `foerderfinder_service_role_key`: Service-role API-Key des Projekts, ausschließlich im Vault.
  - `foerderfinder_source_check_secret`: derselbe geheime Wert wie `SOURCE_CHECK_SECRET` bei den Edge-Function-Secrets.
- Fehlen die Vault-Secrets, beendet sich der Cron-Aufruf ohne HTTP-Anfrage; der Job ist dann nicht funktionstüchtig.
- Werte niemals in GitHub oder Chat schreiben. Supabase Vault im Dashboard benutzen.
- Nach Konfiguration: einmalig `select public.invoke_benefit_source_check();` ausführen, anschließend `source_checks` prüfen; `pg_net` arbeitet asynchron.
