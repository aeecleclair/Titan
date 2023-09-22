import 'package:myecl/tricount/class/transaction_type.dart';
import 'package:myecl/user/class/list_users.dart';

class Transaction {
  late final double amount;
  late final TransactionType type;
  late final String title;
  late final String? description;
  late final DateTime creationDate;
  late final SimpleUser payer;
  late final List<SimpleUser> beneficiaries;

  Transaction({
    required this.amount,
    required this.type,
    required this.title,
    required this.description,
    required this.creationDate,
    required this.payer,
    required this.beneficiaries,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    type = TransactionType.values[json['type']];
    title = json['title'];
    description = json['description'];
    creationDate = DateTime.parse(json['creationDate']);
    payer = SimpleUser.fromJson(json['payer']);
    if (json['beneficiaries'] != null) {
      beneficiaries = <SimpleUser>[];
      json['beneficiaries'].forEach((v) {
        beneficiaries.add(SimpleUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['type'] = type.index;
    data['title'] = title;
    data['description'] = description;
    data['creationDate'] = creationDate.toIso8601String();
    data['payer'] = payer.toJson();
    data['beneficiaries'] = beneficiaries.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  String toString() {
    return 'Transaction{amount: $amount, type: $type, title: $title, description: $description, creationDate: $creationDate, payer: $payer, beneficiaries: $beneficiaries}';
  }

  Transaction copyWith({
    double? amount,
    TransactionType? type,
    String? title,
    String? description,
    DateTime? creationDate,
    SimpleUser? payer,
    List<SimpleUser>? beneficiaries,
  }) {
    return Transaction(
      amount: amount ?? this.amount,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      creationDate: creationDate ?? this.creationDate,
      payer: payer ?? this.payer,
      beneficiaries: beneficiaries ?? this.beneficiaries,
    );
  }

  Transaction.empty() {
    amount = 0;
    type = TransactionType.expense;
    title = '';
    description = '';
    creationDate = DateTime.now();
    payer = SimpleUser.empty();
    beneficiaries = <SimpleUser>[];
  }
}