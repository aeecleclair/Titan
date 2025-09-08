import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/paiement/class/history.dart';
import 'package:titan/paiement/providers/my_history_provider.dart';

class SelectedTransactionsNotifier extends StateNotifier<List<History>> {
  SelectedTransactionsNotifier(super.history);

  void updateSelectedTransactions(List<History> selectedTransactions) {
    state = selectedTransactions;
  }
}

final selectedTransactionsProvider =
    StateNotifierProvider.family<
      SelectedTransactionsNotifier,
      List<History>,
      DateTime
    >((ref, currentMonth) {
      final history = ref.watch(myHistoryProvider);
      return history.maybeWhen(
        orElse: () => SelectedTransactionsNotifier([]),
        data: (history) => SelectedTransactionsNotifier(
          history
              .where(
                (element) =>
                    (element.status == TransactionStatus.confirmed ||
                        element.status == TransactionStatus.refunded) &&
                    element.creation.year == currentMonth.year &&
                    element.creation.month == currentMonth.month,
              )
              .toList(),
        ),
      );
    });
