import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class MockData {}

class MockSingleNotifier extends SingleNotifier<MockData> {
  MockSingleNotifier() : super(const AsyncLoading());

  Future<AsyncValue<MockData>> testLoadList(
    Future<MockData> Function() f,
  ) async {
    return load(f);
  }

  Future<bool> testAdd(
    Future<MockData> Function(MockData t) f,
    MockData t,
  ) async {
    return add(f, t);
  }

  Future<bool> testUpdate(
    Future<bool> Function(MockData t) f,
    MockData t,
  ) async {
    return update(f, t);
  }

  Future<bool> testDelete(
    Future<bool> Function(String id) f,
    String id,
    MockData t,
  ) async {
    return delete(f, t, id);
  }
}

void main() {
  group('Testing SingleNotifier : loadList', () {
    test('Should initiate to AsyncLoading', () {
      final notifier = MockSingleNotifier();
      expect(notifier.state, isA<AsyncLoading>());
    });

    test('Should state be AsyncData when loading data', () async {
      final notifier = MockSingleNotifier();
      final data = MockData();
      await notifier.testLoadList(() => Future.value(data));
      expect(notifier.state, AsyncValue.data(data));
    });

    test(
      'Should rethrow AppException for loadList when function throw AppException.tokenExpire',
      () async {
        final notifier = MockSingleNotifier();
        final error = AppException(ErrorType.tokenExpire, 'test');
        try {
          await notifier.testLoadList(() => Future.error(error));
          expect(notifier.state, isA<AsyncData>()); // not reached
        } catch (e) {
          expect(e, error);
          expect(notifier.state, isA<AsyncError>());
        }
      },
    );

    test(
      'Should return AppException.notFound for loadList when function throw AppException.notFound',
      () async {
        final notifier = MockSingleNotifier();
        final error = AppException(ErrorType.notFound, 'test');
        final result = await notifier.testLoadList(() => Future.error(error));
        expect(notifier.state, isA<AsyncError<MockData>>());
        expect(result, isA<AsyncError<MockData>>());
      },
    );

    test(
      'Should return Exception for loadList when function throw other Exception',
      () async {
        final notifier = MockSingleNotifier();
        final error = Exception('test');
        final result = await notifier.testLoadList(() => throw error);
        expect(notifier.state, isA<AsyncError<MockData>>());
        expect(result, isA<AsyncError<MockData>>());
      },
    );
  });

  group('Testing SingleNotifier : add', () {
    test('Should returns true and updates state on success', () async {
      final notifier = MockSingleNotifier();
      final data = MockData();
      notifier.state = AsyncValue.data(data);
      final newData = MockData();
      final result = await notifier.testAdd(
        (t) => Future.value(newData),
        newData,
      );
      expect(result, isTrue);
      expect(notifier.state, isA<AsyncData<MockData>>());
      expect(
        notifier.state.when(
          data: (d) => d,
          error: (e, s) => [],
          loading: () => [],
        ),
        newData,
      );
    });

    test(
      'Should throw AppException.tokenExpire and restores state on previous data when add fails with AppException.tokenExpire',
      () async {
        final notifier = MockSingleNotifier();
        final data = MockData();
        notifier.state = AsyncValue.data(data);
        final newData = MockData();
        final error = AppException(ErrorType.tokenExpire, 'test');
        try {
          await notifier.testAdd((t) => throw error, newData);
          expect(notifier.state, isA<AsyncData<MockData>>()); // not reached
        } catch (e) {
          expect(e, error);
          expect(notifier.state, isA<AsyncData<MockData>>());
          expect(
            notifier.state.when(
              data: (d) => d,
              error: (e, s) => [],
              loading: () => [],
            ),
            data,
          );
        }
      },
    );

    test(
      'Should return false and restores state on previous data when add fails with AppException.notFound',
      () async {
        final notifier = MockSingleNotifier();
        final data = MockData();
        notifier.state = AsyncValue.data(data);
        final newData = MockData();
        final error = AppException(ErrorType.notFound, 'test');
        final result = await notifier.testAdd((t) => throw error, newData);
        expect(result, isFalse);
        expect(notifier.state, isA<AsyncData<MockData>>());
        expect(
          notifier.state.when(
            data: (d) => d,
            error: (e, s) => [],
            loading: () => [],
          ),
          data,
        );
      },
    );

    test(
      'Should return false sets state on error when start state is AsyncLoading',
      () async {
        final notifier = MockSingleNotifier();
        final newData = MockData();
        final result = await notifier.testAdd((t) => Future.value(t), newData);
        expect(result, isFalse);
        expect(notifier.state, isA<AsyncError>());
        expect(notifier.state.error, "Cannot add while loading");
      },
    );

    test(
      'Should return false sets state on error when start state is AsyncError',
      () async {
        final notifier = MockSingleNotifier();
        notifier.state = AsyncValue.error("test", StackTrace.current);
        final newData = MockData();
        final error = AppException(ErrorType.notFound, 'test');
        final result = await notifier.testAdd((t) => throw error, newData);
        expect(result, isFalse);
        expect(notifier.state, isA<AsyncError>());
        expect(notifier.state.error, "test");
      },
    );
  });

  group('Testing SingleNotifier : update', () {
    test('Should returns true and updates state on success', () async {
      final notifier = MockSingleNotifier();
      final data = MockData();
      notifier.state = AsyncValue.data(data);
      final newData = MockData();
      final result = await notifier.testUpdate(
        (t) => Future.value(true),
        newData,
      );
      expect(result, isTrue);
      expect(notifier.state, isA<AsyncData<MockData>>());
      expect(
        notifier.state.when(
          data: (d) => d,
          error: (e, s) => [],
          loading: () => [],
        ),
        newData,
      );
    });

    test(
      'Should return false and restores state on previous data when update function return false',
      () async {
        final notifier = MockSingleNotifier();
        final data = MockData();
        notifier.state = AsyncValue.data(data);
        final newData = MockData();
        final result = await notifier.testUpdate(
          (t) => Future.value(false),
          newData,
        );
        expect(result, isFalse);
        expect(notifier.state, isA<AsyncData<MockData>>());
        expect(
          notifier.state.when(
            data: (d) => d,
            error: (e, s) => [],
            loading: () => [],
          ),
          data,
        );
      },
    );

    test(
      'Should throw AppException.tokenExpire and restores state on previous data when add fails with AppException.tokenExpire',
      () async {
        final notifier = MockSingleNotifier();
        final data = MockData();
        notifier.state = AsyncValue.data(data);
        final newData = MockData();
        final error = AppException(ErrorType.tokenExpire, 'test');
        try {
          await notifier.testUpdate((t) => throw error, newData);
          expect(notifier.state, isA<AsyncData<MockData>>()); // not reached
        } catch (e) {
          expect(e, error);
          expect(notifier.state, isA<AsyncData<MockData>>());
          expect(
            notifier.state.when(
              data: (d) => d,
              error: (e, s) => [],
              loading: () => [],
            ),
            data,
          );
          expect(
            notifier.state.when(
                  data: (d) => d,
                  error: (e, s) => [],
                  loading: () => [],
                ) ==
                newData,
            isFalse,
          );
        }
      },
    );

    test(
      'Should return false and restores state on previous data when add fails with AppException.notFound',
      () async {
        final notifier = MockSingleNotifier();
        final data = MockData();
        notifier.state = AsyncValue.data(data);
        final newData = MockData();
        final error = AppException(ErrorType.notFound, 'test');
        final result = await notifier.testUpdate((t) => throw error, newData);
        expect(result, isFalse);
        expect(notifier.state, isA<AsyncData<MockData>>());
        expect(
          notifier.state.when(
            data: (d) => d,
            error: (e, s) => [],
            loading: () => [],
          ),
          data,
        );
        expect(
          notifier.state.when(
                data: (d) => d,
                error: (e, s) => [],
                loading: () => [],
              ) ==
              newData,
          isFalse,
        );
      },
    );

    test(
      'Should return false sets state on error when start state is AsyncLoading',
      () async {
        final notifier = MockSingleNotifier();
        final newData = MockData();
        final result = await notifier.testUpdate(
          (t) => Future.value(true),
          newData,
        );
        expect(result, isFalse);
        expect(notifier.state, isA<AsyncError>());
        expect(notifier.state.error, "Cannot update while loading");
      },
    );

    test(
      'Should return false sets state on error when start state is AsyncError',
      () async {
        final notifier = MockSingleNotifier();
        notifier.state = AsyncValue.error("test", StackTrace.current);
        final newData = MockData();
        final result = await notifier.testUpdate(
          (t) => Future.value(true),
          newData,
        );
        expect(result, isFalse);
        expect(notifier.state, isA<AsyncError>());
        expect(notifier.state.error, "test");
      },
    );

    test(
      'Should return false sets state on error when start state is AsyncError(AppException.notFound)',
      () async {
        final notifier = MockSingleNotifier();
        final error = AppException(ErrorType.notFound, 'test');
        notifier.state = AsyncValue.error(error, StackTrace.current);
        final newData = MockData();
        final result = await notifier.testUpdate(
          (t) => Future.value(true),
          newData,
        );
        expect(result, isFalse);
        expect(notifier.state, isA<AsyncError>());
        expect(notifier.state.error, error);
      },
    );

    test(
      'Should return false sets state on error when start state is AsyncError(AppException.tokenExpire)',
      () async {
        final notifier = MockSingleNotifier();
        final error = AppException(ErrorType.tokenExpire, 'test');
        notifier.state = AsyncValue.error(error, StackTrace.current);
        final newData = MockData();
        try {
          await notifier.testUpdate((t) => Future.value(true), newData);
          expect(notifier.state, isA<AsyncError>()); // not reached
        } catch (e) {
          expect(e, error);
          expect(notifier.state, isA<AsyncError>());
          expect(notifier.state.error, error);
        }
      },
    );
  });

  group('Testing SingleNotifier : delete', () {
    test('Should returns true and updates state on success', () async {
      final notifier = MockSingleNotifier();
      final data = MockData();
      notifier.state = AsyncValue.data(data);
      final result = await notifier.testDelete(
        (id) => Future.value(true),
        'id',
        data,
      );
      expect(result, isTrue);
      expect(notifier.state, isA<AsyncLoading>());
    });

    test(
      'Should return false and restores state on previous data when update function return false',
      () async {
        final notifier = MockSingleNotifier();
        final data = MockData();
        notifier.state = AsyncValue.data(data);
        final result = await notifier.testDelete(
          (id) => Future.value(false),
          'id',
          data,
        );
        expect(result, isFalse);
        expect(notifier.state, isA<AsyncData<MockData>>());
        expect(
          notifier.state.when(
            data: (d) => d,
            error: (e, s) => [],
            loading: () => [],
          ),
          data,
        );
      },
    );

    test(
      'Should throw AppException.tokenExpire and restores state on previous data when add fails with AppException.tokenExpire',
      () async {
        final notifier = MockSingleNotifier();
        final data = MockData();
        notifier.state = AsyncValue.data(data);
        final error = AppException(ErrorType.tokenExpire, 'test');
        try {
          await notifier.testDelete((t) => throw error, 'id', data);
          expect(notifier.state, isA<AsyncData<MockData>>()); // not reached
        } catch (e) {
          expect(e, error);
          expect(notifier.state, isA<AsyncData<MockData>>());
          expect(
            notifier.state.when(
              data: (d) => d,
              error: (e, s) => [],
              loading: () => [],
            ),
            data,
          );
        }
      },
    );

    test(
      'Should return false and restores state on previous data when add fails with AppException.notFound',
      () async {
        final notifier = MockSingleNotifier();
        final data = MockData();
        notifier.state = AsyncValue.data(data);
        final error = AppException(ErrorType.notFound, 'test');
        final result = await notifier.testDelete(
          (t) => throw error,
          'id',
          data,
        );
        expect(result, isFalse);
        expect(notifier.state, isA<AsyncData<MockData>>());
        expect(
          notifier.state.when(
            data: (d) => d,
            error: (e, s) => [],
            loading: () => [],
          ),
          data,
        );
      },
    );

    test(
      'Should return false sets state on error when start state is AsyncLoading',
      () async {
        final notifier = MockSingleNotifier();
        final data = MockData();
        final result = await notifier.testDelete(
          (id) => Future.value(true),
          'id',
          data,
        );
        expect(result, isFalse);
        expect(notifier.state, isA<AsyncError>());
        expect(notifier.state.error, "Cannot delete while loading");
      },
    );

    test(
      'Should return false sets state on error when start state is AsyncError',
      () async {
        final notifier = MockSingleNotifier();
        notifier.state = AsyncValue.error("test", StackTrace.current);
        final data = MockData();
        final result = await notifier.testDelete(
          (id) => Future.value(true),
          'id',
          data,
        );
        expect(result, isFalse);
        expect(notifier.state, isA<AsyncError>());
        expect(notifier.state.error, "test");
      },
    );

    test(
      'Should return false sets state on error when start state is AsyncError(AppException.notFound)',
      () async {
        final notifier = MockSingleNotifier();
        final error = AppException(ErrorType.notFound, 'test');
        notifier.state = AsyncValue.error(error, StackTrace.current);
        final data = MockData();
        final result = await notifier.testDelete(
          (id) => Future.value(true),
          'id',
          data,
        );
        expect(result, isFalse);
        expect(notifier.state, isA<AsyncError>());
        expect(notifier.state.error, error);
      },
    );

    test(
      'Should return false sets state on error when start state is AsyncError(AppException.tokenExpire)',
      () async {
        final notifier = MockSingleNotifier();
        final error = AppException(ErrorType.tokenExpire, 'test');
        notifier.state = AsyncValue.error(error, StackTrace.current);
        final data = MockData();
        try {
          await notifier.testDelete((t) => Future.value(true), 'id', data);
          expect(notifier.state, isA<AsyncError>()); // not reached
        } catch (e) {
          expect(e, error);
          expect(notifier.state, isA<AsyncError>());
          expect(notifier.state.error, error);
        }
      },
    );
  });
}
