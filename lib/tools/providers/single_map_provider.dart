import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class SingleMapNotifier<T, E> extends StateNotifier<Map<T, AsyncValue<E>?>> {
  SingleMapNotifier() : super(<T, AsyncValue<E>?>{});

  void loadTList(List<T> tList) async {
    Map<T, AsyncValue<E>?> tMap = {};
    for (T l in tList) {
      tMap[l] = null;
    }
    state = tMap;
  }

  void addT(T t) {
    if (!state.containsKey(t)) {
      state = {...state, t: null};
    }
  }

  void setTData(T t, AsyncValue<E> value) {
    state[t] = value;
    state = Map.of(state);
  }

  void deleteT(T t) {
    if (state.containsKey(t)) {
      final newState = Map.of(state)..remove(t);
      state = newState;
    }
  }

  void resetAll() {
    state = state.map((key, _) => MapEntry(key, null));
  }

  Future<void> autoLoad(
    WidgetRef ref,
    T t,
    Future<AsyncValue<E>> Function(T t) loader,
  ) async {
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
