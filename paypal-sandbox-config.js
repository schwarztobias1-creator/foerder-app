// Öffentliche PayPal-Sandbox-Konfiguration für Förderfinder.
// Die Client-ID ist öffentlich. NIEMALS den PayPal-Secret-Key hier speichern.
// Checkout darf erst aktiviert werden, wenn serverseitige Order-Erstellung,
// Capture und Prüfung des Betrags/der Währung implementiert sind.
window.FOERDER_PAYPAL = Object.freeze({
  environment: "sandbox",
  clientId: "AWjvJaDF8wSu1sGTxnJtOHnD4275x4liurxZEfsmCOcOxpbNSAEEl97X3nX69BiFVUNLncDvKVDh-uwM",
  amount: "9.90",
  currency: "EUR",
  purchaseType: "one_time",
  checkoutEnabled: false
});
