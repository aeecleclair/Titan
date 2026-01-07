import 'package:titan/mypayment/class/history_refund.dart';
import 'package:titan/tools/functions.dart';

enum HistoryType { transfer, received, given, refundCredited, refundDebited }

String historyTypeToString(HistoryType e) {
  switch (e) {
    case HistoryType.refundCredited:
      return "refund_credited";
    case HistoryType.refundDebited:
      return "refund_debited";
    default:
      return e.toString().split('.').last;
  }
}

enum TransactionStatus { confirmed, canceled, refunded, pending }

class History {
  final String id;
  final HistoryType type;
  final String otherWalletName;
  final int total;
  final DateTime creation;
  final TransactionStatus status;
  final HistoryRefund? refund;

  History({
    required this.id,
    required this.type,
    required this.otherWalletName,
    required this.total,
    required this.creation,
    required this.status,
    this.refund,
  });

  History.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      type = HistoryType.values.firstWhere(
        (e) => historyTypeToString(e) == json['type'],
      ),
      otherWalletName = json['other_wallet_name'],
      total = json['total'],
      creation = processDateFromAPI(json['creation']),
      status = TransactionStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      refund = json['refund'] != null
          ? HistoryRefund.fromJson(json['refund'])
          : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': historyTypeToString(type),
    'other_wallet_name': otherWalletName,
    'total': total,
    'creation': processDateToAPI(creation),
    'status': status.toString().split('.').last,
    'refund': refund?.toJson(),
  };

  @override
  String toString() {
    return 'History {id: $id, type: $type, otherWalletName: $otherWalletName, total: $total, creation: $creation, status: $status, refund: $refund}';
  }

  History.empty()
    : id = '',
      type = HistoryType.transfer,
      otherWalletName = '',
      total = 0,
      creation = DateTime.now(),
      status = TransactionStatus.confirmed,
      refund = null;

  History copyWith({
    String? id,
    HistoryType? type,
    String? otherWalletName,
    int? total,
    DateTime? creation,
    TransactionStatus? status,
    HistoryRefund? refund,
  }) {
    return History(
      id: id ?? this.id,
      type: type ?? this.type,
      otherWalletName: otherWalletName ?? this.otherWalletName,
      total: total ?? this.total,
      creation: creation ?? this.creation,
      status: status ?? this.status,
      refund: refund ?? this.refund,
    );
  }
}
