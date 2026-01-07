import 'package:titan/mypayment/class/store.dart';
import 'package:titan/mypayment/class/structure.dart';
import 'package:titan/tools/functions.dart';

class InvoiceDetail {
  final int total;
  final StoreSimple store;

  InvoiceDetail({required this.total, required this.store});

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) {
    return InvoiceDetail(
      total: json['total'],
      store: StoreSimple.fromJson(json['store']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'total': total, 'store': store.toJson()};
  }

  @override
  String toString() {
    return 'InvoiceDetail {total: $total, store: $store}';
  }
}

class Invoice {
  final String id;
  final String reference;
  final Structure structure;
  final DateTime creation;
  final DateTime startDate;
  final DateTime endDate;
  final int total;
  final List<InvoiceDetail> details;
  final bool paid;
  final bool received;

  Invoice({
    required this.id,
    required this.reference,
    required this.structure,
    required this.creation,
    required this.startDate,
    required this.endDate,
    required this.total,
    required this.details,
    required this.paid,
    required this.received,
  });

  Invoice.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      reference = json['reference'],
      structure = Structure.fromJson(json['structure']),
      creation = processDateFromAPI(json['creation']),
      startDate = processDateFromAPI(json['start_date']),
      endDate = processDateFromAPI(json['end_date']),
      total = json['total'],
      details = List<InvoiceDetail>.from(
        json['details'].map((item) => InvoiceDetail.fromJson(item)),
      ),
      paid = json['paid'],
      received = json['received'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'structure': structure.toJson(),
      'creation': processDateToAPI(creation),
      'start_date': processDateToAPI(startDate),
      'end_date': processDateToAPI(endDate),
      'total': total,
      'detail': details.map((item) => item.toJson()).toList(),
      'paid': paid,
      'received': received,
    };
  }

  Invoice.empty()
    : id = '',
      reference = '',
      structure = Structure.empty(),
      creation = DateTime.now(),
      startDate = DateTime.now(),
      endDate = DateTime.now(),
      total = 0,
      details = [],
      paid = false,
      received = false;

  Invoice copyWith({
    String? id,
    String? reference,
    Structure? structure,
    DateTime? creation,
    DateTime? startDate,
    DateTime? endDate,
    int? total,
    List<InvoiceDetail>? details,
    bool? paid,
    bool? received,
  }) {
    return Invoice(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      structure: structure ?? this.structure,
      creation: creation ?? this.creation,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      total: total ?? this.total,
      details: details ?? this.details,
      paid: paid ?? this.paid,
      received: received ?? this.received,
    );
  }

  @override
  String toString() {
    return 'Invoice {id: $id,\n'
        'reference: $reference,\n'
        'structure: $structure,\n'
        'creation: $creation,\n'
        'startDate: $startDate,\n'
        'endDate: $endDate,\n'
        'total: $total,\n'
        'detail: $details,\n'
        'paid: $paid,\n'
        'received: $received}';
  }
}
