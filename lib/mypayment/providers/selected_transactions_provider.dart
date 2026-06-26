import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.enums.swagger.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/mypayment/providers/my_history_provider.dart';

class SelectedTransactionsNotifier extends Notifier<List<History>> {
  SelectedTransactionsNotifier(this.currentMonth);
  final DateTime currentMonth;

  @override
  List<History> build() {
    final history = ref.watch(myHistoryProvider);
    return history.maybeWhen(
      orElse: () => [],
      data: (history) => history
          .where(
            (element) =>
                (element.status == TransactionStatus.confirmed ||
                    element.status == TransactionStatus.refunded) &&
                element.creation.year == currentMonth.year &&
                element.creation.month == currentMonth.month,
          )
          .toList(),
    );
  }

  void updateSelectedTransactions(List<History> selectedTransactions) {
    state = selectedTransactions;
  }
}

final selectedTransactionsProvider =
    NotifierProvider.family<
      SelectedTransactionsNotifier,
      List<History>,
      DateTime
    >(SelectedTransactionsNotifier.new);
