import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/exception.dart';

class MapNotifier<T, E>
    extends StateNotifier<AsyncValue<Map<T, AsyncValue<List<E>>>>> {
  MapNotifier({required String token}) : super(const AsyncLoading());

  void loadTList(List<T> tList) async {
    Map<T, AsyncValue<List<E>>> loanersItems = {};
    for (T l in tList) {
      loanersItems[l] = const AsyncValue.data([]);
    }
    state = AsyncValue.data(loanersItems);
  }

  Future addT(T t) async {
    state.when(
      data: (loanersItems) async {
        loanersItems[t] = const AsyncValue.data([]);
        state = AsyncValue.data(loanersItems);
      },
      loading: () {},
      error: (e, s) {},
    );
  }

  void addE(T t, E e) {
    state.when(data: (d) async {
      try {
        List<E> currentLoans =
            d[t]!.when(data: (d) => d, error: (e, s) => [], loading: () => []);
        d[t] = AsyncValue.data(currentLoans + [e]);
        state = AsyncValue.data(d);
        return true;
      } catch (error) {
        state = AsyncValue.data(d);
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          rethrow;
        } else {
          state = AsyncValue.error(error, StackTrace.empty);
          return false;
        }
      }
    }, error: (error, s) {
      if (error is AppException && error.type == ErrorType.tokenExpire) {
        throw error;
      } else {
        state = AsyncValue.error(error, s);
        return false;
      }
    }, loading: () {
      state =
          const AsyncValue.error("Cannot add while loading", StackTrace.empty);
      return false;
    });
  }

  Future<bool> deleteT(T t) {
    return state.when(data: (d) async {
      try {
        d.remove(t);
        state = AsyncValue.data(d);
        return true;
      } catch (error) {
        state = AsyncValue.data(d);
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          rethrow;
        } else {
          state = AsyncValue.error(error, StackTrace.empty);
          return false;
        }
      }
    }, error: (error, s) async {
      if (error is AppException && error.type == ErrorType.tokenExpire) {
        throw error;
      } else {
        state = AsyncValue.error(error, s);
        return false;
      }
    }, loading: () async {
      state = const AsyncValue.error(
          "Cannot delete while loading", StackTrace.empty);
      return false;
    });
  }

  Future<bool> setTData(T t, AsyncValue<List<E>> asyncEList) async {
    return state.when(data: (d) async {
      try {
        d[t] = asyncEList;
        state = AsyncValue.data(d);
        return true;
      } catch (error) {
        state = AsyncValue.data(d);
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          rethrow;
        } else {
          state = AsyncValue.error(error, StackTrace.empty);
          return false;
        }
      }
    }, error: (error, s) {
      if (error is AppException && error.type == ErrorType.tokenExpire) {
        throw error;
      } else {
        state = AsyncValue.error(error, s);
        return false;
      }
    }, loading: () {
      state =
          const AsyncValue.error("Cannot add while loading", StackTrace.empty);
      return false;
    });
  }
}
