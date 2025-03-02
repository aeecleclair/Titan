import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/exception.dart';

abstract class ListNotifierAPI<T> extends StateNotifier<AsyncValue<List<T>>> {
  ListNotifierAPI(AsyncValue state) : super(const AsyncLoading());

  Future<E> errorWrapper<E>(
    Future<E> Function() f,
    E Function(Object) errorResponse,
  ) async {
    try {
      return await f();
    } catch (e) {
      if (e is AppException && e.type == ErrorType.tokenExpire) {
        rethrow;
      } else {
        return errorResponse(e);
      }
    }
  }

  Future<AsyncValue<List<T>>> loadList(
    Future<Response<List<T>>> Function() f,
  ) async {
    return errorWrapper(
      () async {
        final response = await f();
        final data = response.body;
        if (response.isSuccessful && data != null) {
          state = AsyncValue.data(data);
          return state;
        } else {
          throw response.error!;
        }
      },
      (error) => AsyncValue.error(error, StackTrace.current),
    );
  }

  Future<AsyncValue<List<T>>> loadFromList(List<T>? listT) async {
    if (listT == null) {
      return state = const AsyncValue.data([]);
    }
    return state = AsyncValue.data(listT);
  }

  Future<bool> handleState(
      Future<bool> Function(List<T> d) f, String errorMessage) async {
    return state.when(
        data: (d) => errorWrapper(() async {
              return await f(d);
            }, (p0) => false),
        error: (error, s) {
          if (error is AppException && error.type == ErrorType.tokenExpire) {
            throw error;
          } else {
            state = AsyncValue.error(error, s);
            return false;
          }
        },
        loading: () {
          state = AsyncValue.error(errorMessage, StackTrace.empty);
          return false;
        });
  }

  Future<bool> add<E>(Future<Response<T>> Function() f, E t) async {
    return handleState((d) async {
      final response = await f();
      final data = response.body;
      if (response.isSuccessful && data != null) {
        d.add(data);
        state = AsyncValue.data(d);
        return true;
      } else {
        throw response.error!;
      }
    }, "Cannot add while loading");
  }

  Future<bool> localAdd<E>(T t) async {
    return handleState((d) async {
      d.add(t);
      state = AsyncValue.data(d);
      return true;
    }, "Cannot add while loading");
  }

  Future<bool> addAll<E>(
    Future<Response<List<T>>> Function(List<E> listT) f,
    List<E> listT,
  ) async {
    return handleState((d) async {
      final response = await f(listT);
      final data = response.body;
      if (response.isSuccessful && data != null) {
        d.addAll(data);
        state = AsyncValue.data(d);
        return true;
      } else {
        throw response.error!;
      }
    }, "Cannot addAll while loading");
  }

  Future<bool> update(
    Future<Response<dynamic>> Function() f,
    String Function(T t) getKey,
    T t,
  ) async {
    return handleState((d) async {
      final response = await f();
      if (response.isSuccessful) {
        d[d.indexWhere((e) => getKey(e) == getKey(t))] = t;
        state = AsyncValue.data(d);
        return true;
      } else {
        throw response.error!;
      }
    }, "Cannot update while loading");
  }

  Future<bool> localUpdate(
    String Function(T t) getKey,
    T t,
  ) async {
    return handleState((d) async {
      d[d.indexWhere((e) => getKey(e) == getKey(t))] = t;
      state = AsyncValue.data(d);
      return true;
    }, "Cannot update while loading");
  }

  Future<bool> delete(
    Future<Response<dynamic>> Function() f,
    String Function(T t) getKey,
    String key,
  ) async {
    return handleState((d) async {
      final response = await f();
      if (response.isSuccessful) {
        d.removeWhere((e) => getKey(e) == key);
        state = AsyncValue.data(d);
        return true;
      } else {
        throw response.error!;
      }
    }, "Cannot delete while loading");
  }

  Future<bool> localDelete(
    String Function(T t) getKey,
    String key,
  ) async {
    return handleState((d) async {
      d.removeWhere((e) => getKey(e) == key);
      state = AsyncValue.data(d);
      return true;
    }, "Cannot delete while loading");
  }
}
