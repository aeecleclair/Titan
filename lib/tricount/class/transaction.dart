import 'package:myecl/tricount/class/transaction_type.dart';

class Transaction {
  late final String id;
  late final double amount;
  late final TransactionType type;
  late final String title;
  late final String? description;
  late final DateTime creationDate;
  late final String payer;
  late final List<String> beneficiaries;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.title,
    required this.description,
    required this.creationDate,
    required this.payer,
    required this.beneficiaries,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    type = TransactionType.values[json['type']];
    title = json['title'];
    description = json['description'];
    creationDate = DateTime.parse(json['creationDate']);
    payer = json['payer'];
    beneficiaries = <String>[];
    if (json['beneficiaries'] != null) {
      json['beneficiaries'].forEach((v) {
        beneficiaries.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['type'] = type.index;
    data['title'] = title;
    data['description'] = description;
    data['creationDate'] = creationDate.toIso8601String();
    data['payer'] = payer;
    data['beneficiaries'] = beneficiaries;
    return data;
  }

  @override
  String toString() {
    return 'Transaction{id: $id, amount: $amount, type: $type, title: $title, description: $description, creationDate: $creationDate, payer: $payer, beneficiaries: $beneficiaries}';
  }

  Transaction copyWith({
    double? amount,
    TransactionType? type,
    String? title,
    String? description,
    DateTime? creationDate,
    String? payer,
    List<String>? beneficiaries,
  }) {
    return Transaction(
      id: id,
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
    id = '';
    amount = 0;
    type = TransactionType.expense;
    title = '';
    description = '';
    creationDate = DateTime.now();
    payer = '';
    beneficiaries = <String>[];
  }
}