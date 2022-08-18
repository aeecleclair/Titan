import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/loan/repositories/item_repository.dart';
import 'package:myecl/tools/exception.dart';
import 'package:tuple/tuple.dart';

class LoanersItems extends StateNotifier<
    AsyncValue<Map<Loaner, Tuple2<AsyncValue<List<Item>>, bool>>>> {
  final ItemRepository _itemRepository = ItemRepository();
  LoanersItems({required String token}) : super(const AsyncLoading()) {
    _itemRepository.setToken(token);
  }

  void loadLoanerList(List<Loaner> loaners) async {
    Map<Loaner, Tuple2<AsyncValue<List<Item>>, bool>> loanersItems = {};
    for (Loaner l in loaners) {
      loanersItems[l] = const Tuple2(AsyncValue.data([]), false);
    }
    state = AsyncValue.data(loanersItems);
  }

  Future<bool> setLoanerItems(
      Loaner loaner, AsyncValue<List<Item>> items) async {
    return state.when(data: (d) async {
      try {
        d[loaner] = Tuple2(items, d[loaner]!.item2);
        state = AsyncValue.data(d);
        return true;
      } catch (error) {
        state = AsyncValue.data(d);
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          rethrow;
        } else {
          state = AsyncValue.error(error);
          return false;
        }
      }
    }, error: (error, s) {
      if (error is AppException && error.type == ErrorType.tokenExpire) {
        throw error;
      } else {
        state = AsyncValue.error(error);
        return false;
      }
    }, loading: () {
      state = const AsyncValue.error("Cannot add while loading");
      return false;
    });
  }

  Future<bool> toggleExpanded(Loaner loaner) {
    return state.when(data: (d) async {
      d[loaner] = Tuple2(d[loaner]!.item1, !d[loaner]!.item2);
      state = AsyncValue.data(d);
      if (d[loaner] == null) {
        return false;
      } else {
        return d[loaner]!.item1.when(
            data: (d) async => d.isNotEmpty,
            error: (e, s) async => false,
            loading: () async => false);
      }
    }, error: (Object error, StackTrace? stackTrace) async {
      return false;
    }, loading: () async {
      return false;
    });
  }
}

final loanersItemsProvider = StateNotifierProvider<LoanersItems,
    AsyncValue<Map<Loaner, Tuple2<AsyncValue<List<Item>>, bool>>>>((ref) {
  final token = ref.watch(tokenProvider);
  final loaners = ref.watch(loanerList);
  LoanersItems _loanerLoanListNotifier = LoanersItems(token: token);
  _loanerLoanListNotifier.loadLoanerList(loaners);
  return _loanerLoanListNotifier;
});
