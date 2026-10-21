# Förderfinder – Zahlungsintegration (Entwicklungsplan)

Status: **nicht aktiviert**. Die öffentliche GitHub-Pages-Seite darf keine PayPal-Secret-Keys enthalten.

## Geplanter Sandbox-Ablauf
1. Browser startet Checkout über eine Supabase Edge Function (create-order), mit serverseitig festgelegtem Betrag 9,90 EUR.
2. Edge Function erstellt über die PayPal Sandbox Orders API eine Bestellung. Zugangsdaten liegen ausschließlich in Supabase Secrets.
3. Browser führt Käufer zur PayPal-Freigabe.
4. Eine serverseitige Edge Function (capture-order) prüft PayPal-Bestell-ID, Betrag, Währung und Status, erfasst die Zahlung und speichert eine eindeutige Kaufberechtigung.
5. Geschützte Premium-Funktionen prüfen die Kaufberechtigung serverseitig; niemals allein anhand eines Browser-Flags.
6. Doppelte Webhook-Zustellungen und wiederholte Capture-Anfragen müssen idempotent sein. Webhook-Signatur validieren.

## Vor Aktivierung erforderlich
- PayPal Business Sandbox-Zugang (Client ID und Secret), sichere Speicherung in Supabase.
- Supabase Projektzugriff und Entscheidung über Nutzeranmeldung oder sicheren Kauf-Token.
- Rechtstexte, Widerrufs-/Digitalinhalte-Regelung, Datenschutz, Impressum, Preis-/Steuerangaben und klare Bestellbeschriftung prüfen.
- End-to-end Sandbox-Test inklusive Abbruch, Rückerstattung, Doppelanfrage und fehlgeschlagener Zahlung.

**Keine Echtgeldzahlungen aktivieren, bevor Premium-Leistung und Checkout geprüft sind.**
