enum MyPaymentCallType {
  transfer, // HelloAsso
  request, // myemapp
}

extension MyPaymentCallTypeExtension on MyPaymentCallType {
  String get value {
    switch (this) {
      case MyPaymentCallType.transfer:
        return 'transfer';
      case MyPaymentCallType.request:
        return 'request';
    }
  }

  static MyPaymentCallType fromString(String value) {
    switch (value) {
      case 'transfer':
        return MyPaymentCallType.transfer;
      case 'request':
        return MyPaymentCallType.request;
      default:
        throw ArgumentError('Unknown MyPaymentCallType: $value');
    }
  }
}
