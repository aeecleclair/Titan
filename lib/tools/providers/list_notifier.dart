import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/exception.dart';

abstract class ListNotifier<T> extends StateNotifier<AsyncValue<List<T>>> {
  ListNotifier(AsyncValue state) : super(const AsyncLoading());

  Future<AsyncValue<List<T>>> loadList(Future<List<T>> Function() f) async {
    try {
      final data = await f();
      state = AsyncValue.data(data);
      return state;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      if (e is AppException && e.type == ErrorType.tokenExpire) {
        rethrow;
      } else {
        return state;
      }
    }
  }

  Future<bool> add(Future<T> Function(T t) f, T t) async {
    return state.when(
      data: (d) async {
        try {
          final newT = await f(t);
          d.add(newT);
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
      },
      error: (error, s) {
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          throw error;
        } else {
          state = AsyncValue.error(error, s);
          return false;
        }
      },
      loading: () {
        state = const AsyncValue.error(
          "Cannot add while loading",
          StackTrace.empty,
        );
        return false;
      },
    );
  }

  Future<bool> addAll(
    Future<List<T>> Function(List<T> listT) f,
    List<T> listT,
  ) async {
    return state.when(
      data: (d) async {
        try {
          final newT = await f(listT);
          d.addAll(newT);
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
      },
      error: (error, s) {
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          throw error;
        } else {
          state = AsyncValue.error(error, s);
          return false;
        }
      },
      loading: () {
        state = const AsyncValue.error(
          "Cannot addAll while loading",
          StackTrace.empty,
        );
        return false;
      },
    );
  }

  Future<bool> update(
    Future<bool> Function(T t) f,
    List<T> Function(List<T> listT, T t) replace,
    T t,
  ) async {
    return state.when(
      data: (d) async {
        try {
          print("ici");
          final value = await f(t);
          if (!value) {
            return false;
          }
          print(d);
          print(t);
          d = replace(d, t);
          state = AsyncValue.data(d);
          print("enfin");
          return true;
        } catch (error) {
          print(error);
          state = AsyncValue.data(d);
          if (error is AppException && error.type == ErrorType.tokenExpire) {
            rethrow;
          } else {
            return false;
          }
        }
      },
      error: (error, s) {
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          throw error;
        } else {
          state = AsyncValue.error(error, s);
          return false;
        }
      },
      loading: () {
        state = const AsyncValue.error(
          "Cannot update while loading",
          StackTrace.empty,
        );
        return false;
      },
    );
  }

  Future<bool> delete(
    Future<bool> Function(String id) f,
    List<T> Function(List<T> listT, T t) replace,
    String id,
    T t,
  ) async {
    return state.when(
      data: (d) async {
        try {
          final value = await f(id);
          if (!value) {
            return false;
          }
          d = replace(d, t);
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
      },
      error: (error, s) {
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          throw error;
        } else {
          state = AsyncValue.error(error, s);
          return false;
        }
      },
      loading: () {
        state = const AsyncValue.error(
          "Cannot delete while loading",
          StackTrace.empty,
        );
        return false;
      },
    );
  }
}
