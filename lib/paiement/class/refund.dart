class Refund {
  final String walletDeviceId;
  final bool completeRefund;
  final int? amount;

  Refund({
    required this.walletDeviceId,
    required this.completeRefund,
    this.amount,
  });

  Refund.fromJson(Map<String, dynamic> json)
      : walletDeviceId = json['wallet_device_id'],
        completeRefund = json['complete_refund'],
        amount = json['amount'];

  Map<String, dynamic> toJson() {
    return {
      'wallet_device_id': walletDeviceId,
      'complete_refund': completeRefund,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return 'Refund{walletDeviceId: $walletDeviceId, completeRefund: $completeRefund, amount: $amount}';
  }

  Refund copyWith({
    String? walletDeviceId,
    bool? completeRefund,
    int? amount,
  }) {
    return Refund(
      walletDeviceId: walletDeviceId ?? this.walletDeviceId,
      completeRefund: completeRefund ?? this.completeRefund,
      amount: amount ?? this.amount,
    );
  }

  Refund.empty()
      : this(walletDeviceId: '', completeRefund: false, amount: 0);
}