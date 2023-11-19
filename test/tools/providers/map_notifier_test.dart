// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class MockE {}

class MockT {}

class MockMapNotifier extends MapNotifier<MockT, MockE> {
  MockMapNotifier() : super();

  Future<void> testLoadTlist(List<MockT> tList) async {
    return loadTList(tList);
  }

  Future<void> testAddT(MockT t) async {
    return addT(t);
  }

  Future<void> testAddE(MockT t, MockE e) async {
    return addE(t, e);
  }

  Future<bool> testDeleteT(MockT t) async {
    return deleteT(t);
  }

  Future<bool> testSetTData(MockT t, AsyncValue<List<MockE>> asyncEList) async {
    return setTData(t, asyncEList);
  }
}

void main() {
  group('Testing MapNotifier : loadTList', () {
    test('Should initiate to AsyncLoading', () {
      final notifier = MockMapNotifier();
      expect(notifier.state, isA<AsyncLoading>());
    });

    test('Should state be AsyncData when loading data', () async {
      final notifier = MockMapNotifier();
      final data = [MockT(), MockT()];
      await notifier.testLoadTlist(data);
      expect(notifier.state,
          isA<AsyncValue<Map<MockT, AsyncValue<List<MockE>>>>>());
      expect(
          notifier.state.when(
              data: (d) => d.keys.toList(),
              error: (Object error, StackTrace stackTrace) => [],
              loading: () => []),
          data);
    });
  });

  // group('Testing MapNotifier : add', () {
  //   test('Should returns true and updates state on success', () async {
  //     final notifier = MockMapNotifier();
  //     final data = [MockE(), MockE()];
  //     notifier.state = AsyncValue.data(data);
  //     final newData = MockE();
  //     final newDataList = [...data, newData];
  //     final result =
  //         await notifier.testAdd((t) => Future.value(newData), newData);
  //     expect(result, isTrue);
  //     expect(notifier.state, isA<AsyncData<List<MockE>>>());
  //     expect(
  //         notifier.state
  //             .when(data: (d) => d, error: (e, s) => [], loading: () => []),
  //         newDataList);
  //   });

  //   test(
  //       'Should throw AppException.tokenExpire and restores state on previous data when add fails with AppException.tokenExpire',
  //       () async {
  //     final notifier = MockMapNotifier();
  //     final data = [MockE(), MockE()];
  //     notifier.state = AsyncValue.data(data);
  //     final newData = MockE();
  //     final error = AppException(ErrorType.tokenExpire, 'test');
  //     try {
  //       await notifier.testAdd((t) => throw error, newData);
  //       expect(notifier.state, isA<AsyncData<List<MockE>>>()); // not reached
  //     } catch (e) {
  //       expect(e, error);
  //       expect(notifier.state, isA<AsyncData<List<MockE>>>());
  //       expect(
  //           notifier.state
  //               .when(data: (d) => d, error: (e, s) => [], loading: () => []),
  //           data);
  //     }
  //   });

  //   test(
  //       'Should return false and restores state on previous data when add fails with AppException.notFound',
  //       () async {
  //     final notifier = MockMapNotifier();
  //     final data = [MockE(), MockE()];
  //     notifier.state = AsyncValue.data(data);
  //     final newData = MockE();
  //     final error = AppException(ErrorType.notFound, 'test');
  //     final result = await notifier.testAdd((t) => throw error, newData);
  //     expect(result, isFalse);
  //     expect(notifier.state, isA<AsyncData<List<MockE>>>());
  //     expect(
  //         notifier.state
  //             .when(data: (d) => d, error: (e, s) => [], loading: () => []),
  //         data);
  //   });

  //   test(
  //       'Should return false sets state on error when start state is AsyncLoading',
  //       () async {
  //     final notifier = MockMapNotifier();
  //     final newData = MockE();
  //     final result = await notifier.testAdd((t) => Future.value(t), newData);
  //     expect(result, isFalse);
  //     expect(notifier.state, isA<AsyncError>());
  //     expect(notifier.state.error, "Cannot add while loading");
  //   });

  //   test(
  //       'Should return false sets state on error when start state is AsyncError',
  //       () async {
  //     final notifier = MockMapNotifier();
  //     notifier.state = AsyncValue.error("test", StackTrace.current);
  //     final newData = MockE();
  //     final error = AppException(ErrorType.notFound, 'test');
  //     final result = await notifier.testAdd((t) => throw error, newData);
  //     expect(result, isFalse);
  //     expect(notifier.state, isA<AsyncError>());
  //     expect(notifier.state.error, "test");
  //   });
  // });

  // group('Testing MapNotifier : update', () {
  //   test('Should returns true and updates state on success', () async {
  //     final notifier = MockMapNotifier();
  //     final data = [MockE(), MockE()];
  //     notifier.state = AsyncValue.data(data);
  //     final newData = MockE();
  //     final newDataList = [newData, ...data.skip(1)];
  //     final result = await notifier.testUpdate((t) => Future.value(true),
  //         (listT, t) => [t, ...listT.skip(1)], newData);
  //     expect(result, isTrue);
  //     expect(notifier.state, isA<AsyncData<List<MockE>>>());
  //     expect(
  //         notifier.state
  //             .when(data: (d) => d, error: (e, s) => [], loading: () => []),
  //         newDataList);
  //   });

  //   test(
  //       'Should return false and restores state on previous data when update function return false',
  //       () async {
  //     final notifier = MockMapNotifier();
  //     final data = [MockE(), MockE()];
  //     notifier.state = AsyncValue.data(data);
  //     final newData = MockE();
  //     final result = await notifier.testUpdate((t) => Future.value(false),
  //         (listT, t) => [t, ...listT.skip(1)], newData);
  //     expect(result, isFalse);
  //     expect(notifier.state, isA<AsyncData<List<MockE>>>());
  //     expect(
  //         notifier.state
  //             .when(data: (d) => d, error: (e, s) => [], loading: () => []),
  //         data);
  //   });

  //   test(
  //       'Should throw AppException.tokenExpire and restores state on previous data when add fails with AppException.tokenExpire',
  //       () async {
  //     final notifier = MockMapNotifier();
  //     final data = [MockE(), MockE()];
  //     notifier.state = AsyncValue.data(data);
  //     final newData = MockE();
  //     final newDataList = [newData, ...data.skip(1)];
  //     final error = AppException(ErrorType.tokenExpire, 'test');
  //     try {
  //       await notifier.testUpdate(
  //           (t) => throw error, (listT, t) => [t, ...listT.skip(1)], newData);
  //       expect(notifier.state, isA<AsyncData<List<MockE>>>()); // not reached
  //     } catch (e) {
  //       expect(e, error);
  //       expect(notifier.state, isA<AsyncData<List<MockE>>>());
  //       expect(
  //           notifier.state
  //               .when(data: (d) => d, error: (e, s) => [], loading: () => []),
  //           data);
  //       expect(
  //           notifier.state.when(
  //                   data: (d) => d, error: (e, s) => [], loading: () => []) ==
  //               newDataList,
  //           isFalse);
  //     }
  //   });

  //   test(
  //       'Should return false and restores state on previous data when add fails with AppException.notFound',
  //       () async {
  //     final notifier = MockMapNotifier();
  //     final data = [MockE(), MockE()];
  //     notifier.state = AsyncValue.data(data);
  //     final newData = MockE();
  //     final newDataList = [newData, ...data.skip(1)];
  //     final error = AppException(ErrorType.notFound, 'test');
  //     final result = await notifier.testUpdate(
  //         (t) => throw error, (listT, t) => [t, ...listT.skip(1)], newData);
  //     expect(result, isFalse);
  //     expect(notifier.state, isA<AsyncData<List<MockE>>>());
  //     expect(
  //         notifier.state
  //             .when(data: (d) => d, error: (e, s) => [], loading: () => []),
  //         data);
  //     expect(
  //         notifier.state.when(
  //                 data: (d) => d, error: (e, s) => [], loading: () => []) ==
  //             newDataList,
  //         isFalse);
  //   });

  //   test(
  //       'Should return false sets state on error when start state is AsyncLoading',
  //       () async {
  //     final notifier = MockMapNotifier();
  //     final newData = MockE();
  //     final result = await notifier.testUpdate((t) => Future.value(true),
  //         (listT, t) => [t, ...listT.skip(1)], newData);
  //     expect(result, isFalse);
  //     expect(notifier.state, isA<AsyncError>());
  //     expect(notifier.state.error, "Cannot update while loading");
  //   });

  //   test(
  //       'Should return false sets state on error when start state is AsyncError',
  //       () async {
  //     final notifier = MockMapNotifier();
  //     notifier.state = AsyncValue.error("test", StackTrace.current);
  //     final newData = MockE();
  //     final result = await notifier.testUpdate((t) => Future.value(true),
  //         (listT, t) => [t, ...listT.skip(1)], newData);
  //     expect(result, isFalse);
  //     expect(notifier.state, isA<AsyncError>());
  //     expect(notifier.state.error, "test");
  //   });
  // });

  // group('Testing MapNotifier : delete', () {
  //   test('Should returns true and updates state on success', () async {
  //     final notifier = MockMapNotifier();
  //     final data = [MockE(), MockE()];
  //     notifier.state = AsyncValue.data(data);
  //     final oldData = data.first;
  //     final newDataList = data.skip(1).toList();
  //     final result = await notifier.testDelete((id) => Future.value(true),
  //         (listT, t) => listT.skip(1).toList(), 'id', oldData);
  //     expect(result, isTrue);
  //     expect(notifier.state, isA<AsyncData<List<MockE>>>());
  //     expect(
  //         notifier.state
  //             .when(data: (d) => d, error: (e, s) => [], loading: () => []),
  //         newDataList);
  //   });

  //   test(
  //       'Should return false and restores state on previous data when update function return false',
  //       () async {
  //     final notifier = MockMapNotifier();
  //     final data = [MockE(), MockE()];
  //     notifier.state = AsyncValue.data(data);
  //     final oldData = data.first;
  //     final result = await notifier.testDelete((id) => Future.value(false),
  //         (listT, t) => listT.skip(1).toList(), 'id', oldData);
  //     expect(result, isFalse);
  //     expect(notifier.state, isA<AsyncData<List<MockE>>>());
  //     expect(
  //         notifier.state
  //             .when(data: (d) => d, error: (e, s) => [], loading: () => []),
  //         data);
  //   });

  //   test(
  //       'Should throw AppException.tokenExpire and restores state on previous data when add fails with AppException.tokenExpire',
  //       () async {
  //     final notifier = MockMapNotifier();
  //     final data = [MockE(), MockE()];
  //     notifier.state = AsyncValue.data(data);
  //     final oldData = data.first;
  //     final newDataList = data.skip(1).toList();
  //     final error = AppException(ErrorType.tokenExpire, 'test');
  //     try {
  //       await notifier.testDelete((t) => throw error,
  //           (listT, t) => listT.skip(1).toList(), 'id', oldData);
  //       expect(notifier.state, isA<AsyncData<List<MockE>>>()); // not reached
  //     } catch (e) {
  //       expect(e, error);
  //       expect(notifier.state, isA<AsyncData<List<MockE>>>());
  //       expect(
  //           notifier.state
  //               .when(data: (d) => d, error: (e, s) => [], loading: () => []),
  //           data);
  //       expect(
  //           notifier.state.when(
  //                   data: (d) => d, error: (e, s) => [], loading: () => []) ==
  //               newDataList,
  //           isFalse);
  //     }
  //   });

  //   test(
  //       'Should return false and restores state on previous data when add fails with AppException.notFound',
  //       () async {
  //     final notifier = MockMapNotifier();
  //     final data = [MockE(), MockE()];
  //     notifier.state = AsyncValue.data(data);
  //     final oldData = data.first;
  //     final newDataList = data.skip(1).toList();
  //     final error = AppException(ErrorType.notFound, 'test');
  //     final result = await notifier.testDelete((t) => throw error,
  //         (listT, t) => listT.skip(1).toList(), 'id', oldData);
  //     expect(result, isFalse);
  //     expect(notifier.state, isA<AsyncData<List<MockE>>>());
  //     expect(
  //         notifier.state
  //             .when(data: (d) => d, error: (e, s) => [], loading: () => []),
  //         data);
  //     expect(
  //         notifier.state.when(
  //                 data: (d) => d, error: (e, s) => [], loading: () => []) ==
  //             newDataList,
  //         isFalse);
  //   });

  //   test(
  //       'Should return false sets state on error when start state is AsyncLoading',
  //       () async {
  //     final notifier = MockMapNotifier();
  //     final data = [MockE(), MockE()];
  //     final oldData = data.first;
  //     final result = await notifier.testDelete((id) => Future.value(true),
  //         (listT, t) => listT.skip(1).toList(), 'id', oldData);
  //     expect(result, isFalse);
  //     expect(notifier.state, isA<AsyncError>());
  //     expect(notifier.state.error, "Cannot delete while loading");
  //   });

  //   test(
  //       'Should return false sets state on error when start state is AsyncError',
  //       () async {
  //     final notifier = MockMapNotifier();
  //     notifier.state = AsyncValue.error("test", StackTrace.current);
  //     final data = [MockE(), MockE()];
  //     final oldData = data.first;
  //     final result = await notifier.testDelete((id) => Future.value(true),
  //         (listT, t) => listT.skip(1).toList(), 'id', oldData);
  //     expect(result, isFalse);
  //     expect(notifier.state, isA<AsyncError>());
  //     expect(notifier.state.error, "test");
  //   });
  // });
}
