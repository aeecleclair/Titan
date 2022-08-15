import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/exception.dart';

abstract class SingleProvider<T> extends StateNotifier<AsyncValue<T>> {
  SingleProvider(AsyncValue state) : super(const AsyncLoading());

  Future<AsyncValue<T>> load(Future<T> Function() f) async {
    try {
      final data = await f();
      state = AsyncValue.data(data);
      return state;
    } catch (e) {
      state = AsyncValue.error(e);
      if (e is AppException && e.type == ErrorType.tokenExpire) {
        rethrow;
      } else {
        return state;
      }
    }
  }

  Future<bool> add(Future<T> Function(T t) f, T t) async {
    return state.when(data: (d) async {
      try {
        final newT = await f(t);
        state = AsyncValue.data(newT);
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

  Future<bool> update(Future<bool> Function(T t) f, T t) async {
    return state.when(data: (d) async {
      try {
        await f(t);
        state = AsyncValue.data(t);
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
      state = const AsyncValue.error("Cannot update while loading");
      return false;
    });
  }

  Future<bool> delete(Future<T> Function() f, T t) async {
    return state.when(data: (d) async {
      try {
        await f();
        state = const AsyncValue.loading();
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
      state = const AsyncValue.error("Cannot delete while loading");
      return false;
    });
  }
}
