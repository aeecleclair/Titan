import 'package:titan/mypayment/class/history_refund.dart';
import 'package:titan/tools/functions.dart';

enum HistoryType {
  refund,
  directTransfer,
  requestTransfer,
  directTransaction,
  requestTransaction,
}

String historyTypeToString(HistoryType e) {
  switch (e) {
    case HistoryType.refund:
      return "refund";
    case HistoryType.directTransfer:
      return "direct_transfer";
    case HistoryType.requestTransfer:
      return "request_transfer";
    case HistoryType.directTransaction:
      return "direct_transaction";
    case HistoryType.requestTransaction:
      return "request_transaction";
  }
}

enum HistoryDirection { credited, debited }

enum TransactionStatus { confirmed, canceled, refunded, pending }

class History {
  final String id;
  final HistoryType type;
  final HistoryDirection direction;
  final String otherWalletName;
  final int total;
  final DateTime creation;
  final TransactionStatus status;
  final HistoryRefund? refund;

  History({
    required this.id,
    required this.type,
    required this.direction,
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
      direction = HistoryDirection.values.firstWhere(
        (e) => e.toString().split('.').last == json['direction'],
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
    'direction': direction.toString().split('.').last,
    'other_wallet_name': otherWalletName,
    'total': total,
    'creation': processDateToAPI(creation),
    'status': status.toString().split('.').last,
    'refund': refund?.toJson(),
  };

  @override
  String toString() {
    return 'History {id: $id, type: $type, direction: $direction, otherWalletName: $otherWalletName, total: $total, creation: $creation, status: $status, refund: $refund}';
  }

  History.empty()
    : id = '',
      type = HistoryType.directTransfer,
      direction = HistoryDirection.credited,
      otherWalletName = '',
      total = 0,
      creation = DateTime.now(),
      status = TransactionStatus.confirmed,
      refund = null;

  History copyWith({
    String? id,
    HistoryType? type,
    HistoryDirection? direction,
    String? otherWalletName,
    int? total,
    DateTime? creation,
    TransactionStatus? status,
    HistoryRefund? refund,
  }) {
    return History(
      id: id ?? this.id,
      type: type ?? this.type,
      direction: direction ?? this.direction,
      otherWalletName: otherWalletName ?? this.otherWalletName,
      total: total ?? this.total,
      creation: creation ?? this.creation,
      status: status ?? this.status,
      refund: refund ?? this.refund,
    );
  }
}
