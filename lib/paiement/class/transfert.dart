import 'package:myecl/paiement/tools/functions.dart';

class Transfer {
  final int amount;
  final TransferType type;
  final String? receiverUserId;

  Transfer({
    required this.amount,
    required this.type,
    this.receiverUserId,
  });

  Transfer.fromJson(Map<String, dynamic> json)
      : amount = json['amount'],
        type = transferTypeFromString(json['transfer_type']),
        receiverUserId = json['receiver_user_id'];

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'transfer_type': transferTypeToString(type),
      'receiver_user_id': receiverUserId,
    };
  }

  @override
  String toString() {
    return 'Transfer{amount: $amount, type: $type, receiverUserId: $receiverUserId}';
  }

  Transfer copyWith({
    int? amount,
    TransferType? type,
    String? receiverUserId,
  }) {
    return Transfer(
      amount: amount ?? this.amount,
      type: type ?? this.type,
      receiverUserId: receiverUserId ?? this.receiverUserId,
    );
  }

  Transfer.empty()
      : this(amount: 0, type: TransferType.helloAsso, receiverUserId: '');
}
