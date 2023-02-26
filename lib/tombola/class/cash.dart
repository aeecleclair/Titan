class Cash {
  Cash({
    required this.balance,
    required this.user_id,
  });
  late final double balance;
  late final String user_id;

  Cash.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    user_id = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = user_id;
    _data['balance'] = balance;
    return _data;
  }
}
