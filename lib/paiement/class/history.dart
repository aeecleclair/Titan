import 'package:myecl/tools/functions.dart';

enum HistoryType { transfer, received, given }

enum TransactionStatus { confirmed, canceled, refunded, pending }

class History {
  final String id;
  final HistoryType type;
  final String otherWalletName;
  final int total;
  final DateTime creation;
  final TransactionStatus status;

  History({
    required this.id,
    required this.type,
    required this.otherWalletName,
    required this.total,
    required this.creation,
    required this.status,
  });

  History.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = HistoryType.values.firstWhere(
          (e) => e.toString().split('.').last == json['type'],
        ),
        otherWalletName = json['other_wallet_name'],
        total = json['total'],
        creation = processDateFromAPI(json['creation']),
        status = TransactionStatus.values.firstWhere(
          (e) => e.toString().split('.').last == json['status'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.toString().split('.').last,
        'other_wallet_name': otherWalletName,
        'total': total,
        'creation': processDateToAPI(creation),
        'status': status.toString().split('.').last,
      };

  @override
  String toString() {
    return 'History {id: $id, type: $type, otherWalletName: $otherWalletName, total: $total, creation: $creation, status: $status}';
  }

  History.empty()
      : id = '',
        type = HistoryType.transfer,
        otherWalletName = '',
        total = 0,
        creation = DateTime.now(),
        status = TransactionStatus.confirmed;
}
