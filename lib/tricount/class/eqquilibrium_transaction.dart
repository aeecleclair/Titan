import 'package:myecl/user/class/list_users.dart';

class EquilibriumTransaction {
  late final SimpleUser from;
  late final SimpleUser to;
  late final double amount;

  EquilibriumTransaction({
    required this.from,
    required this.to,
    required this.amount,
  });

  EquilibriumTransaction.fromJson(Map<String, dynamic> json) {
    from = SimpleUser.fromJson(json['from']);
    to = SimpleUser.fromJson(json['to']);
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from'] = from.toJson();
    data['to'] = to.toJson();
    data['amount'] = amount;
    return data;
  }

  @override
  String toString() {
    return 'EquilibriumTransaction{from: $from, to: $to, amount: $amount}';
  }

  EquilibriumTransaction copyWith({
    SimpleUser? from,
    SimpleUser? to,
    double? amount,
  }) {
    return EquilibriumTransaction(
      from: from ?? this.from,
      to: to ?? this.to,
      amount: amount ?? this.amount,
    );
  }

  EquilibriumTransaction.empty() {
    from = SimpleUser.empty();
    to = SimpleUser.empty();
    amount = 0;
  }
}
