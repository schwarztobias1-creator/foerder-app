# Förder-App Österreich

Mobile-first Förderfinder für Privatpersonen in Österreich. MVP: Familienleistungen.

## Prinzipien
- Kostenloser Fördercheck ohne Login, eine Frage pro Bildschirm
- Verständliche Sprache, optionale Vorlesefunktion und Spracheingabe
- Ergebnisstatus: möglicherweise berechtigt, bereits bezogen, Angaben fehlen, nicht passend
- KI erklärt Fragen und hilft bei Antragsvorbereitung; Förderansprüche werden anhand geprüfter, datierter Regeln bestimmt
- Keine personenbezogenen Echtdaten im Repository oder in Testumgebungen

## Architektur (geplant)
Mobile Web-App (PWA), separate Supabase-Datenbank in EU-Region, serverseitige KI, später PayPal-Checkout mit serverseitiger Zahlungsprüfung.

## Vor Veröffentlichung
Förderregeln anhand amtlicher Quellen prüfen; Zugriffskontrollen/RLS testen; Datenschutzkonzept und Rechtsgrundlage für sensible Verarbeitung klären; sichere Dokumentenverarbeitung und Löschkonzept; Zahlungsintegration und fachliche Prüfung.

## Nächste Schritte
1. Mobilen Fragebogen als Prototyp implementieren
2. Regelwerk für Familienförderungen verifizieren
3. Erklär-Assistent und Sprachbedienung integrieren
4. Geschützte Antragsvorbereitung und Bezahlung ergänzen

## Geschäftsmodell (festgelegt 2026-10-21)
- Kostenloser grundlegender Fördercheck.
- Einmalige PayPal-Zahlung für einen Premium-Förderbericht; **kein Abonnement**.
- Preis noch offen. PayPal-Checkout noch nicht implementiert.
- Zahlungsfreischaltung ausschließlich nach serverseitiger PayPal-Bestätigung, niemals allein anhand eines Browser-Redirects.

## Förderdatenbank
- Supabase-Projekt `foerder-app` mit versionierten Förderungen, amtlichen Quellen und RLS.
- Erste fünf Informationsdatensätze am 2026-10-21 geprüft und gespeichert.
- Die Startdaten sind kein vollständiger österreichweiter Katalog und keine individuelle Anspruchszusage.
- Bei AMS und NÖ Wohnzuschuss ist `valid_from` zunächst das Quellen-Veröffentlichungsdatum, **nicht** der rechtliche Beginn der Förderregel; vor präziser historischer Anspruchsprüfung ist das zu korrigieren.
- Automatische Quellenüberwachung und fachlicher Freigabeprozess noch umzusetzen.
