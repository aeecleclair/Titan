import 'package:myecl/user/class/list_users.dart';

class Cash {
  Cash({required this.balance, required this.user});
  late final double balance;
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

  Cash copyWith({user, balance}) {
    return Cash(user: user ?? this.user, balance: balance ?? this.balance);
  }

  @override
  String toString() {
    return 'Cash{balance: $balance, user: $user}';
  }
}
