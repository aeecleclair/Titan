/// Why the MyEMPay wallet cannot be used to pay right now.
enum CanPayError {
  tosNotAccepted,
  noDevice,
  deviceInactive,
  deviceRevoked,
  insufficientBalance,
}

class CanPayResult {
  final bool success;
  final CanPayError? error;

  const CanPayResult.ok() : success = true, error = null;
  const CanPayResult.fail(this.error) : success = false;
}
