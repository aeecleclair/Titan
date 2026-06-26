import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleMapNotifier<T, E> extends Notifier<Map<T, AsyncValue<E>?>> {
  @override
  Map<T, AsyncValue<E>?> build() {
    return <T, AsyncValue<E>?>{};
  }

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
    loader(t).then((value) {
      setTData(t, value);
    });
  }
}
