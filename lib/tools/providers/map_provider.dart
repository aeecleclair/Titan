import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class MapNotifier<T, E> extends StateNotifier<Map<T, AsyncValue<List<E>>?>> {
  MapNotifier() : super(<T, AsyncValue<List<E>>?>{});

  void loadTList(List<T> tList) async {
    Map<T, AsyncValue<List<E>>?> tMap = {};
    for (T l in tList) {
      tMap[l] = null;
    }
    state = tMap;
  }

  void addT(T t) async {
    state[t] = null;
    state = state;
  }

  void addE(T t, E e) {
    return state[t]!.maybeWhen(data: (eList) {
      state[t] = AsyncValue.data(eList + [e]);
      state = state;
    }, orElse: () {
      state[t] = AsyncValue.data([e]);
      state = state;
    });
  }

  void deleteT(T t) {
    if (state.containsKey(t)) {
      state.remove(t);
      state = state;
    }
  }

  void setTData(T t, AsyncValue<List<E>> asyncEList) async {
    state[t] = asyncEList;
    state = state;
  }

  bool deleteE(T t, int index) {
    return state[t]!.maybeWhen(
        data: (eList) {
          eList.removeAt(index);
          state[t] = AsyncValue.data(eList);
          state = state;
          return true;
        },
        orElse: () => false);
  }

  Future<void> autoLoad(
      WidgetRef ref, T t, Future<E> Function(T t) loader) async {
    setTData(t, const AsyncLoading());
    tokenExpireWrapper(ref, () async {
      loader(t).then((value) {
        if (mounted) {
          setTData(t, AsyncData([value]));
        }
      });
    });
  }

  Future<void> autoLoadList(WidgetRef ref, T t,
      Future<AsyncValue<List<E>>> Function(T t) loader) async {
    setTData(t, const AsyncLoading());
    tokenExpireWrapper(ref, () async {
      loader(t).then((value) {
        if (mounted) {
          setTData(t, value);
        }
      });
    });
  }
}
