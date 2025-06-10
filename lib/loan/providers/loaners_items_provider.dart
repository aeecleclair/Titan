import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/class/item.dart';
import 'package:titan/loan/class/loaner.dart';
import 'package:titan/loan/providers/user_loaner_list_provider.dart';
import 'package:titan/tools/providers/map_provider.dart';

class LoanersItemsNotifier extends MapNotifier<Loaner, Item> {
  LoanersItemsNotifier() : super();
}

final loanersItemsProvider =
    StateNotifierProvider<
      LoanersItemsNotifier,
      Map<Loaner, AsyncValue<List<Item>>?>
    >((ref) {
      final loaners = ref.watch(loanerList);
      LoanersItemsNotifier loanerLoanListNotifier = LoanersItemsNotifier();
      loanerLoanListNotifier.loadTList(loaners);
      return loanerLoanListNotifier;
    });
