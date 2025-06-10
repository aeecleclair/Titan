import 'package:titan/paiement/class/history.dart';
import 'package:titan/tools/functions.dart';

enum TransactionType { direct, request, refund }

class Transaction {
  final String id;
  final String debitedWalletId;
  final String creditedWalletId;
  final TransactionType transactionType;
  final String? sellerUserId;
  final int total;
  final DateTime creation;
  final TransactionStatus status;

  Transaction({
    required this.id,
    required this.debitedWalletId,
    required this.creditedWalletId,
    required this.transactionType,
    this.sellerUserId,
    required this.total,
    required this.creation,
    required this.status,
  });

  Transaction.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      debitedWalletId = json['debited_wallet_id'],
      creditedWalletId = json['credited_wallet_id'],
      transactionType = TransactionType.values.firstWhere(
        (e) => e.toString().split('.').last == json['transaction_type'],
      ),
      sellerUserId = json['seller_user_id'],
      total = json['total'],
      creation = processDateFromAPI(json['creation']),
      status = TransactionStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'debited_wallet_id': debitedWalletId,
    'credited_wallet_id': creditedWalletId,
    'transaction_type': transactionType.toString().split('.').last,
    'seller_user_id': sellerUserId,
    'total': total,
    'creation': processDateToAPI(creation),
    'status': status.toString().split('.').last,
  };

  @override
  String toString() {
    return 'Transaction {id: $id, debitedWalletId: $debitedWalletId, creditedWalletId: $creditedWalletId, transactionType: $transactionType, sellerUserId: $sellerUserId, total: $total, creation: $creation, status: $status}';
  }

  Transaction.empty()
    : id = '',
      debitedWalletId = '',
      creditedWalletId = '',
      transactionType = TransactionType.direct,
      sellerUserId = '',
      total = 0,
      creation = DateTime.now(),
      status = TransactionStatus.confirmed;
}
