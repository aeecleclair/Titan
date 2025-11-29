import 'package:titan/user/class/simple_users.dart';

class Cash {
  Cash({required this.balance, required this.user});
  late final int balance;
  late final SimpleUser user;

  Cash.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    user = SimpleUser.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['balance'] = balance;
    return data;
  }

  Cash copyWith({SimpleUser? user, int? balance}) {
    return Cash(user: user ?? this.user, balance: balance ?? this.balance);
  }

  static Cash empty() => Cash(user: SimpleUser.empty(), balance: 0);

  @override
  String toString() {
    return 'Cash{balance: $balance, user: $user}';
  }
}
