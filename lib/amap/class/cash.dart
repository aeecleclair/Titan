import 'package:titan/user/class/simple_users.dart';
import 'package:titan/tools/functions.dart';

class Cash {
  Cash({
    required this.balance,
    required this.user,
    required this.lastOrderDate,
  });
  late final int balance;
  late final SimpleUser user;
  late final DateTime lastOrderDate;

  Cash.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    user = SimpleUser.fromJson(json['user']);
    lastOrderDate = processDateFromAPI(json['last_order_date']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['balance'] = balance;
    data['last_order_date'] = processDateToAPI(lastOrderDate);
    return data;
  }

  Cash copyWith({SimpleUser? user, int? balance, DateTime? lastOrderDate}) {
    return Cash(
      user: user ?? this.user,
      balance: balance ?? this.balance,
      lastOrderDate: lastOrderDate ?? this.lastOrderDate,
    );
  }

  static Cash empty() =>
      Cash(user: SimpleUser.empty(), balance: 0, lastOrderDate: DateTime.now());

  @override
  String toString() {
    return 'Cash{balance: $balance, user: $user, lastOrderDate: $lastOrderDate}';
  }
}
