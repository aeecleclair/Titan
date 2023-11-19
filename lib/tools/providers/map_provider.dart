import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class MapNotifier<T, E>
    extends StateNotifier<AsyncValue<Map<T, AsyncValue<List<E>>>>> {
  MapNotifier() : super(const AsyncLoading());

  void loadTList(List<T> tList) async {
    Map<T, AsyncValue<List<E>>> tMap = {};
    for (T l in tList) {
      tMap[l] = const AsyncValue.data([]);
    }
    state = AsyncValue.data(tMap);
  }

  Future addT(T t) async {
    state.maybeWhen(
      data: (loanersItems) async {
        loanersItems[t] = const AsyncValue.data([]);
        state = AsyncValue.data(loanersItems);
      },
      orElse: () {},
    );
  }

  void addE(T t, E e) {
    state.when(data: (d) async {
      try {
        List<E> currentLoans =
            d[t]!.maybeWhen(data: (d) => d, orElse: () => []);
        d[t] = AsyncValue.data(currentLoans + [e]);
        state = AsyncValue.data(d);
        return true;
      } catch (error) {
        state = AsyncValue.data(d);
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          rethrow;
        } else {
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

  Future<bool> deleteE(T t, int index) {
    return state.when(data: (d) async {
      try {
        List<E> eList = d[t]!.maybeWhen(data: (d) => d, orElse: () => []);
        eList.removeAt(index);
        d[t] = AsyncValue.data(eList);
        state = AsyncValue.data(d);
        return true;
      } catch (error) {
        state = AsyncValue.data(d);
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          rethrow;
        } else {
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
      state =
          const AsyncValue.error("Cannot add while loading", StackTrace.empty);
      return false;
    });
  }

  Future<void> autoLoad(
      WidgetRef ref, T t, Future<E> Function(T t) loader) async {
    Future.delayed(const Duration(milliseconds: 1), () {
      setTData(t, const AsyncLoading());
    });
    tokenExpireWrapper(ref, () async {
      loader(t).then((value) {
        setTData(t, AsyncData([value]));
      });
    });
  }

  Future<void> autoLoadList(WidgetRef ref, T t,
      Future<AsyncValue<List<E>>> Function(T t) loader) async {
    Future.delayed(const Duration(milliseconds: 1), () {
      setTData(t, const AsyncLoading());
    });
    tokenExpireWrapper(ref, () async {
      loader(t).then((value) {
        setTData(t, value);
      });
    });
  }
}
