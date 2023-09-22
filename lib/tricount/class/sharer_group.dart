import 'package:myecl/tricount/class/eqquilibrium_transaction.dart';
import 'package:myecl/tricount/class/transaction.dart';
import 'package:myecl/user/class/list_users.dart';

class SharerGroup {
  late final String id;
  late final String name;
  late final List<SimpleUser> sharers;
  late final List<EquilibriumTransaction> equilibriumTransactions;
  late final List<Transaction> transactions;
  late final double totalAmount;

  SharerGroup({
    required this.id,
    required this.name,
    required this.sharers,
    required this.equilibriumTransactions,
    required this.transactions,
    required this.totalAmount,
  });

  SharerGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['sharers'] != null) {
      sharers = <SimpleUser>[];
      json['sharers'].forEach((v) {
        sharers.add(SimpleUser.fromJson(v));
      });
    }
    if (json['equilibriumTransactions'] != null) {
      equilibriumTransactions = <EquilibriumTransaction>[];
      json['equilibriumTransactions'].forEach((v) {
        equilibriumTransactions.add(EquilibriumTransaction.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      transactions = <Transaction>[];
      json['transactions'].forEach((v) {
        transactions.add(Transaction.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sharers'] = sharers.map((v) => v.toJson()).toList();
    data['equilibriumTransactions'] =
        equilibriumTransactions.map((v) => v.toJson()).toList();
    data['transactions'] = transactions.map((v) => v.toJson()).toList();
    data['totalAmount'] = totalAmount;
    return data;
  }

  @override
  String toString() {
    return 'SharerGroup{id: $id, name: $name, sharers: $sharers, equilibriumTransactions: $equilibriumTransactions, transactions: $transactions, totalAmount: $totalAmount}';
  }

  SharerGroup copyWith({
    String? id,
    String? name,
    List<SimpleUser>? sharers,
    List<EquilibriumTransaction>? equilibriumTransactions,
    List<Transaction>? transactions,
    double? totalAmount,
  }) {
    return SharerGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      sharers: sharers ?? this.sharers,
      equilibriumTransactions:
          equilibriumTransactions ?? this.equilibriumTransactions,
      transactions: transactions ?? this.transactions,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  SharerGroup.empty() {
    id = '';
    name = '';
    sharers = <SimpleUser>[];
    equilibriumTransactions = <EquilibriumTransaction>[];
    transactions = <Transaction>[];
    totalAmount = 0;
  }
}