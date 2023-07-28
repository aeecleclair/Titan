import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:tuple/tuple.dart';

class ToggleMapNotifier<T, E> extends StateNotifier<
    AsyncValue<Map<T, Tuple2<AsyncValue<List<E>>, bool>>>> {
  ToggleMapNotifier({required String token}) : super(const AsyncLoading());

  Future loadTList(List<T> tList) async {
    Map<T, Tuple2<AsyncValue<List<E>>, bool>> tMap = {};
    for (T l in tList) {
      tMap[l] = const Tuple2(AsyncValue.data([]), false);
    }
    state = AsyncValue.data(tMap);
  }

  Future addT(T t) async {
    state.maybeWhen(
      data: (tMap) async {
        tMap[t] = const Tuple2(AsyncValue.data([]), false);
        state = AsyncValue.data(tMap);
      },
      orElse: () {},
    );
  }

  Future addE(T t, E e) {
    return state.when(data: (d) async {
      try {
        List<E> eList = d[t]!.item1.maybeWhen(data: (d) => d, orElse: () => []);
        d[t] = Tuple2(AsyncValue.data(eList + [e]), d[t]!.item2);
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

  Future<bool> deleteE(T t, int index) {
    return state.when(data: (d) async {
      try {
        List<E> eList = d[t]!.item1.maybeWhen(data: (d) => d, orElse: () => []);
        eList.removeAt(index);
        d[t] = Tuple2(AsyncValue.data(eList), d[t]!.item2);
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

  Future<bool> setTData(T t, AsyncValue<List<E>> asyncEList) async {
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

  Future<void> autoLoad(WidgetRef ref, T t,
      Future<AsyncValue<List<E>>> Function(T t) loader,
      Function(AsyncValue<List<E>> value)? postProcess) async {
    Future.delayed(const Duration(milliseconds: 1), () {
      setTData(t, const AsyncLoading());
    });
    tokenExpireWrapper(ref, () async {
      loader(t).then((value) {
        setTData(t, value);
        postProcess?.call(value);
      });
    });
  }
}
