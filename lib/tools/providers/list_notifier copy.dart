import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/exception.dart';

abstract class ListNotifier2<T> extends StateNotifier<AsyncValue<List<T>>> {
  ListNotifier2(AsyncValue state) : super(const AsyncLoading());

  Future<AsyncValue<List<T>>> loadList(Future<Response<List<T>>> Function() f) async {
    try {
      final response = await f();
      final data = response.body;
      if (response.isSuccessful && data != null) {
        state = AsyncValue.data(data);
        return state;
      } else {
        throw response.error!;
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      if (e is AppException && e.type == ErrorType.tokenExpire) {
        rethrow;
      } else {
        return state;
      }
    }
  }

  Future<bool> add(Future<Response<T>> Function(T t) f, T t) async {
    return state.when(data: (d) async {
      try {
        final response = await f(t);
        final data = response.body;
        if (response.isSuccessful && data != null) {
          d.add(data);
          state = AsyncValue.data(d);
          return true;
        } else {
          throw response.error!;
        }
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

  Future<bool> addAll(
      Future<Response<List<T>>> Function(List<T> listT) f, List<T> listT) async {
    return state.when(data: (d) async {
      try {
        final response = await f(listT);
        final data = response.body;
        if (response.isSuccessful && data != null) {
          d.addAll(data);
          state = AsyncValue.data(d);
          return true;
        } else {
          throw response.error!;
        }
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
      state = const AsyncValue.error(
          "Cannot addAll while loading", StackTrace.empty);
      return false;
    });
  }

  Future<bool> update(Future<Response<dynamic>> Function(T t) f,
      List<T> Function(List<T> listT, T t) replace, T t) async {
    return state.when(data: (d) async {
      try {
        final response = await f(t);
        if (response.isSuccessful) {
          d = replace(d, t);
          state = AsyncValue.data(d);
          return true;
        } else {
          throw response.error!;
        }
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
      state = const AsyncValue.error(
          "Cannot update while loading", StackTrace.empty);
      return false;
    });
  }

  Future<bool> delete(Future<Response<dynamic>> Function(String id) f,
      List<T> Function(List<T> listT, T t) replace, String id, T t) async {
    return state.when(data: (d) async {
      try {
        final response = await f(id);
        if (response.isSuccessful) {
          d = replace(d, t);
          state = AsyncValue.data(d);
          return true;
        } else {
          throw response.error!;
        }
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
      state = const AsyncValue.error(
          "Cannot delete while loading", StackTrace.empty);
      return false;
    });
  }
}
