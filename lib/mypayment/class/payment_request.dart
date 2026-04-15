import 'package:titan/tools/functions.dart';

enum RequestStatus { proposed, accepted, refused, expired }

class PaymentRequest {
  final String id;
  final String walletId;
  final DateTime creation;
  final DateTime endDate;
  final int total;
  final String storeId;
  final String name;
  final String? storeNote;
  final String module;
  final String objectId;
  final RequestStatus status;
  final String? transactionId;

  PaymentRequest({
    required this.id,
    required this.walletId,
    required this.creation,
    required this.endDate,
    required this.total,
    required this.storeId,
    required this.name,
    this.storeNote,
    required this.module,
    required this.objectId,
    required this.status,
    this.transactionId,
  });

  PaymentRequest.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      walletId = json['wallet_id'],
      creation = processDateFromAPI(json['creation']),
      endDate = processDateFromAPI(json['end_date']),
      total = json['total'],
      storeId = json['store_id'],
      name = json['name'],
      storeNote = json['store_note'],
      module = json['module'],
      objectId = json['object_id'],
      status = RequestStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      transactionId = json['transaction_id'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'wallet_id': walletId,
    'creation': processDateToAPI(creation),
    'end_date': processDateToAPI(endDate),
    'total': total,
    'store_id': storeId,
    'name': name,
    'store_note': storeNote,
    'module': module,
    'object_id': objectId,
    'status': status.toString().split('.').last,
    'transaction_id': transactionId,
  };

  @override
  String toString() {
    return 'PaymentRequest {id: $id, walletId: $walletId, creation: $creation, endDate: $endDate, total: $total, storeId: $storeId, name: $name, status: $status}';
  }

  PaymentRequest.empty()
    : id = '',
      walletId = '',
      creation = DateTime.now(),
      endDate = DateTime.now(),
      total = 0,
      storeId = '',
      name = '',
      storeNote = null,
      module = '',
      objectId = '',
      status = RequestStatus.proposed,
      transactionId = null;

  PaymentRequest copyWith({
    String? id,
    String? walletId,
    DateTime? creation,
    DateTime? endDate,
    int? total,
    String? storeId,
    String? name,
    String? storeNote,
    String? module,
    String? objectId,
    RequestStatus? status,
    String? transactionId,
  }) {
    return PaymentRequest(
      id: id ?? this.id,
      walletId: walletId ?? this.walletId,
      creation: creation ?? this.creation,
      endDate: endDate ?? this.endDate,
      total: total ?? this.total,
      storeId: storeId ?? this.storeId,
      name: name ?? this.name,
      storeNote: storeNote ?? this.storeNote,
      module: module ?? this.module,
      objectId: objectId ?? this.objectId,
      status: status ?? this.status,
      transactionId: transactionId ?? this.transactionId,
    );
  }
}
