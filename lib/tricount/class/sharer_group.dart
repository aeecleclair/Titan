import 'package:myecl/tricount/class/balance.dart';
import 'package:myecl/tricount/class/transaction.dart';
import 'package:myecl/user/class/list_users.dart';

class SharerGroup {
  late final String id;
  late final String name;
  late final List<SimpleUser> members;
  late final List<Transaction> transactions;
  late final double total;
  late final List<Balance> balances;

  SharerGroup({
    required this.id,
    required this.name,
    required this.members,
    required this.transactions,
    required this.total,
    required this.balances,
  });

  SharerGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['members'] != null) {
      members = <SimpleUser>[];
      json['members'].forEach((v) {
        members.add(SimpleUser.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      transactions = <Transaction>[];
      json['transactions'].forEach((v) {
        transactions.add(Transaction.fromJson(v));
      });
    }
    total = json['total'];
    if (json['balances'] != null) {
      balances = <Balance>[];
      json['balances'].forEach((v) {
        balances.add(Balance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['members'] = members.map((v) => v.toJson()).toList();
    data['transactions'] = transactions.map((v) => v.toJson()).toList();
    data['total'] = total;
    data['balances'] = balances.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  String toString() {
    return 'SharerGroup{id: $id, name: $name, members: $members, transactions: $transactions, total: $total, balances: $balances}';
  }

  SharerGroup copyWith({
    String? id,
    String? name,
    List<SimpleUser>? members,
    List<Transaction>? transactions,
    double? total,
    List<Balance>? balances,
  }) {
    return SharerGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      members: members ?? this.members,
      transactions: transactions ?? this.transactions,
      total: total ?? this.total,
      balances: balances ?? this.balances,
    );
  }

  SharerGroup.empty() {
    id = '';
    name = '';
    members = <SimpleUser>[];
    transactions = <Transaction>[];
    total = 0;
    balances = <Balance>[];
  }
}