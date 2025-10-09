class Refund {
  final bool completeRefund;
  final int? amount;

  Refund({required this.completeRefund, this.amount});

  Refund.fromJson(Map<String, dynamic> json)
    : completeRefund = json['complete_refund'],
      amount = json['amount'];

  Map<String, dynamic> toJson() {
    return {'complete_refund': completeRefund, 'amount': amount};
  }

  @override
  String toString() {
    return 'Refund{completeRefund: $completeRefund, amount: $amount}';
  }

  Refund copyWith({bool? completeRefund, int? amount}) {
    return Refund(
      completeRefund: completeRefund ?? this.completeRefund,
      amount: amount ?? this.amount,
    );
  }

  Refund.empty() : this(completeRefund: false, amount: 0);
}
