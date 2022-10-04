import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/tools/exception.dart';
import 'package:tuple/tuple.dart';

class LoanHistoryNotifier extends StateNotifier<
    AsyncValue<Map<Loaner, Tuple2<AsyncValue<List<Loan>>, bool>>>> {
  LoanHistoryNotifier({required String token}) : super(const AsyncLoading());

  void loadLoanerList(List<Loaner> loaners) async {
    Map<Loaner, Tuple2<AsyncValue<List<Loan>>, bool>> loanersItems = {};
    for (Loaner l in loaners) {
      loanersItems[l] = const Tuple2(AsyncValue.data([]), false);
    }
    state = AsyncValue.data(loanersItems);
  }

  void addLoan(Loaner loaner, Loan loan) {
    state.when(data: (d) async {
      try {
        List<Loan> currentLoans = d[loaner]!
            .item1
            .when(data: (d) => d, error: (e, s) => [], loading: () => []);
        d[loaner] =
            Tuple2(AsyncValue.data(currentLoans + [loan]), d[loaner]!.item2);
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

  Future<bool> setLoanerItems(
      Loaner loaner, AsyncValue<List<Loan>> loans) async {
    return state.when(data: (d) async {
      try {
        d[loaner] = Tuple2(loans, d[loaner]!.item2);
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

final loanHistoryProvider = StateNotifierProvider<LoanHistoryNotifier,
    AsyncValue<Map<Loaner, Tuple2<AsyncValue<List<Loan>>, bool>>>>((ref) {
  final token = ref.watch(tokenProvider);
  final loaners = ref.watch(loanerList);
  LoanHistoryNotifier loanHistoryNotifier = LoanHistoryNotifier(token: token);
  loanHistoryNotifier.loadLoanerList(loaners);
  return loanHistoryNotifier;
});
