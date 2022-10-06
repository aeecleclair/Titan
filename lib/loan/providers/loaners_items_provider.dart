import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:tuple/tuple.dart';

class LoanersItems extends MapNotifier<Loaner, Item> {
  LoanersItems({required String token}) : super(token: token);
}

final loanersItemsProvider = StateNotifierProvider<LoanersItems,
    AsyncValue<Map<Loaner, Tuple2<AsyncValue<List<Item>>, bool>>>>((ref) {
  final token = ref.watch(tokenProvider);
  final loaners = ref.watch(loanerList);
  LoanersItems loanerLoanListNotifier = LoanersItems(token: token);
  loanerLoanListNotifier.loadTList(loaners);
  return loanerLoanListNotifier;
});
