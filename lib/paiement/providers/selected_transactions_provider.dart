import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/class/history.dart';
import 'package:myecl/paiement/providers/my_history_provider.dart';
import 'package:myecl/paiement/providers/selected_month_provider.dart';

class SelectedTransactionsNotifier extends StateNotifier<List<History>> {
  SelectedTransactionsNotifier(super.history);

  void updateSelectedTransactions(List<History> selectedTransactions) {
    state = selectedTransactions;
  }
}

final selectedTransactionsProvider =
    StateNotifierProvider<SelectedTransactionsNotifier, List<History>>((ref) {
  final history = ref.watch(myHistoryProvider);
  final currentMonth = ref.watch(selectedMonthProvider);
  return history.maybeWhen(
    orElse: () => SelectedTransactionsNotifier([]),
    data: (history) => SelectedTransactionsNotifier(
      history
          .where(
            (element) =>
                element.status == TransactionStatus.confirmed &&
                element.creation.year == currentMonth.year &&
                element.creation.month == currentMonth.month,
          )
          .toList(),
    ),
  );
});
