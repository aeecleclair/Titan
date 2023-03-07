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
}
