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
        d.add(newT);
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

  Future<bool> update(Future<bool> Function(T t) f,
      List<T> Function(List<T> listT, T t) replace, T t) async {
    return state.when(data: (d) async {
      try {
        await f(t);
        d = replace(d, t);
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
      state = const AsyncValue.error("Cannot update while loading");
      return false;
    });
  }

  Future<bool> delete(Future<bool> Function(String id) f,
      List<T> Function(List<T> listT, T t) replace, String id, T t) async {
    return state.when(data: (d) async {
      try {
        await f(id);
        d = replace(d, t);
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
      state = const AsyncValue.error("Cannot delete while loading");
      return false;
    });
  }
}
