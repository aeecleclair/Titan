class Balance {
  late final String userId;
  late final double amount;

  Balance(
      {required this.userId,
      required this.amount});

  Balance.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['amount'] = amount;
    return data;
  }

  @override
  String toString() {
    return 'Balance{userId: $userId, amount: $amount}';
  }

  Balance copyWith({
    String? userId,
    double? amount,
  }) {
    return Balance(
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
    );
  }

  Balance.empty()
      : this(
            userId: '',
            amount: 0.0);
}
