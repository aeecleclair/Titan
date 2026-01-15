import 'package:titan/mypayment/tools/functions.dart';

class Transfer {
  final int amount;
  final TransferType type;
  final String? creditedUserId;

  Transfer({required this.amount, required this.type, this.creditedUserId});

  Transfer.fromJson(Map<String, dynamic> json)
    : amount = json['amount'],
      type = transferTypeFromString(json['transfer_type']),
      creditedUserId = json['credited_user_id'];

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'transfer_type': transferTypeToString(type),
      'credited_user_id': creditedUserId,
    };
  }

  @override
  String toString() {
    return 'Transfer{amount: $amount, type: $type, creditedUserId: $creditedUserId}';
  }

  Transfer copyWith({int? amount, TransferType? type, String? creditedUserId}) {
    return Transfer(
      amount: amount ?? this.amount,
      type: type ?? this.type,
      creditedUserId: creditedUserId ?? this.creditedUserId,
    );
  }

  Transfer.empty()
    : this(amount: 0, type: TransferType.helloAsso, creditedUserId: '');
}
