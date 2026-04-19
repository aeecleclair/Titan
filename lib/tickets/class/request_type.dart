enum RequestType {
  // User is redirected to a checkout page; total is credited to the store wallet as a transfer.
  transferRequest,
  // Once accepted by the user, a transaction is created between the user wallet and the store wallet.
  transactionRequest,
}

extension RequestTypeExtension on RequestType {
  String get value {
    switch (this) {
      case RequestType.transferRequest:
        return 'transfer';
      case RequestType.transactionRequest:
        return 'request';
    }
  }

  static RequestType fromString(String value) {
    switch (value) {
      case 'transfer':
        return RequestType.transferRequest;
      case 'request':
        return RequestType.transactionRequest;
      default:
        throw ArgumentError('Unknown RequestType: $value');
    }
  }
}
