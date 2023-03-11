class Cash {
  Cash({
    required this.balance,
    required this.userId,
  });
  late final double balance;
  late final String userId;

  Cash.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['balance'] = balance;
    return data;
  }

  Cash.copyWith({
    double? balance,
    String? userId,
  }) {
    this.balance = balance ?? this.balance;
    this.userId = userId ?? this.userId;
  }

  Cash.empty() {
    balance = 0;
    userId = '';
  }

  @override
  String toString() {
    return 'Cash{balance: $balance, userId: $userId}';
  }
}
