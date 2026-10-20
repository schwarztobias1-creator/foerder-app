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
