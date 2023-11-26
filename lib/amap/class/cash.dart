import 'package:myecl/generated/openapi.swagger.dart';

class Cash {
  Cash({required this.balance, required this.user});
  late final double balance;
  late final CoreUserSimple user;

  Cash.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    user = CoreUserSimple.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['balance'] = balance;
    return data;
  }

  Cash copyWith({CoreUserSimple? user, double? balance}) {
    return Cash(user: user ?? this.user, balance: balance ?? this.balance);
  }

  static Cash empty() => Cash(user: CoreUserSimple.fromJson({}), balance: 0);

  @override
  String toString() {
    return 'Cash{balance: $balance, user: $user}';
  }
}
