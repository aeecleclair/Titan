import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/exception.dart';

abstract class SingleNotifier<T> extends StateNotifier<AsyncValue<T>> {
  SingleNotifier(AsyncValue state) : super(const AsyncLoading());

  Future<AsyncValue<T>> load(Future<T> Function() f) async {
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
          state = AsyncValue.data(newT);
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

  Future<bool> update(Future<bool> Function(T t) f, T t) async {
    return state.when(
      data: (d) async {
        try {
          final value = await f(t);
          if (!value) {
            return false;
          }
          state = AsyncValue.data(t);
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
          "Cannot update while loading",
          StackTrace.empty,
        );
        return false;
      },
    );
  }

  Future<bool> delete(
    Future<bool> Function(String id) f,
    T t,
    String id,
  ) async {
    return state.when(
      data: (d) async {
        try {
          final value = await f(id);
          if (!value) {
            return false;
          }
          state = const AsyncValue.loading();
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
