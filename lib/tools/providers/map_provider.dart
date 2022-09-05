import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/exception.dart';
import 'package:tuple/tuple.dart';

class MapNotifier<T, E> extends StateNotifier<
    AsyncValue<Map<T, Tuple2<AsyncValue<List<E>>, bool>>>> {
  MapNotifier({required String token}) : super(const AsyncLoading());

  void loadTList(List<T> tList) async {
    Map<T, Tuple2<AsyncValue<List<E>>, bool>> loanersItems = {};
    for (T l in tList) {
      loanersItems[l] = const Tuple2(AsyncValue.data([]), false);
    }
    state = AsyncValue.data(loanersItems);
  }

  Future addT(T t) async {
    state.when(
      data: (loanersItems) async {
        loanersItems[t] = const Tuple2(AsyncValue.data([]), false);
        state = AsyncValue.data(loanersItems);
      },
      loading: () {},
      error: (e, s) {},
    );
  }

  void addE(T t, E e) {
    state.when(data: (d) async {
      try {
        List<E> currentLoans = d[t]!
            .item1
            .when(data: (d) => d, error: (e, s) => [], loading: () => []);
        d[t] =
            Tuple2(AsyncValue.data(currentLoans + [e]), d[t]!.item2);
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

  Future<bool> setTData(
      T t, AsyncValue<List<E>> asyncEList) async {
    return state.when(data: (d) async {
      try {
        d[t] = Tuple2(asyncEList, d[t]!.item2);
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

  Future<bool> toggleExpanded(T t) {
    return state.when(data: (d) async {
      d[t] = Tuple2(d[t]!.item1, !d[t]!.item2);
      state = AsyncValue.data(d);
      if (d[t] == null) {
        return false;
      } else {
        return d[t]!.item1.when(
            data: (a) async => a.isNotEmpty || !d[t]!.item2,
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
