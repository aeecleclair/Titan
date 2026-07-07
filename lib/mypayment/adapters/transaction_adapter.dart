import 'package:titan/generated/openapi.enums.swagger.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

extension $TransactionBaseToHistory on TransactionBase {
  History toHistory() {
    return History(
      id: id,
      type: transactionType == TransactionType.request
          ? HistoryType.requestTransaction
          : HistoryType.directTransaction,
      direction: HistoryDirection.credited,
      otherWalletName: '',
      total: total,
      creation: creation,
      status: status,
    );
  }
}
