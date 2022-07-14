class Cash {
  Cash({
    required this.balance,
  });
  late final double balance;

  Cash.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['balance'] = balance;
    return _data;
  }

  Cash copyWith({id, balance}) {
    return Cash(
        balance: balance ?? this.balance);
  }
}