// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/providers/toggle_map_provider.dart';
import 'package:tuple/tuple.dart';

class MockE {}

class MockT {}

class MockToggleMapNotifier extends ToggleMapNotifier<MockT, MockE> {
  MockToggleMapNotifier() : super();

  Future<void> testLoadTlist(List<MockT> tList) async {
    return loadTList(tList);
  }

  Future<void> testAddT(MockT t) async {
    return addT(t);
  }

  Future<bool> testAddE(MockT t, MockE e) async {
    return addE(t, e);
  }

  Future<bool> testDeleteT(MockT t, int index) async {
    return deleteE(t, index);
  }

  Future<bool> testSetTData(MockT t, AsyncValue<List<MockE>> asyncEList) async {
    return setTData(t, asyncEList);
  }

  Future<bool> testToggleExpanded(MockT t) async {
    return toggleExpanded(t);
  }
}

void main() {
  group('Testing ToggleMapNotifier : loadTList', () {
    test('Should initiate to AsyncLoading', () {
      final notifier = MockToggleMapNotifier();
      expect(notifier.state, isA<AsyncLoading>());
    });

    test('Should state be AsyncData when loading data', () async {
      final notifier = MockToggleMapNotifier();
      final data = [MockT(), MockT()];
      await notifier.testLoadTlist(data);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>>());
      expect(
          notifier.state.when(
              data: (d) => d.keys.toList(),
              error: (Object error, StackTrace stackTrace) => [],
              loading: () => []),
          data);
      expect(
          notifier.state.when(
              data: (d) => d.values.first,
              error: (Object error, StackTrace stackTrace) => null,
              loading: () => null),
          isA<Tuple2<AsyncValue<List<MockE>>, bool>>());
    });
  });

  group('Testing ToggleMapNotifier : addT', () {
    test('Should updates state on success', () async {
      final notifier = MockToggleMapNotifier();
      final data = <MockT, Tuple2<AsyncValue<List<MockE>>, bool>>{
        MockT(): Tuple2(AsyncValue.data(<MockE>[]), false),
        MockT(): Tuple2(AsyncValue.data(<MockE>[]), false),
      };
      notifier.state = AsyncValue.data(data);
      final newData = MockT();
      await notifier.testAddT(newData);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>>());
      expect(
          notifier.state
              .when(data: (d) => d, error: (e, s) => {}, loading: () => {})
              .keys
              .contains(newData),
          isTrue);
      expect(
          notifier.state
              .when(
                  data: (d) => d,
                  error: (e, s) => {},
                  loading: () => {})[newData]!
              .item1,
          isA<AsyncData<List<MockE>>>());
    });

    test('Should sets state on loading when start state is AsyncLoading',
        () async {
      final notifier = MockToggleMapNotifier();
      final newData = MockT();
      await notifier.testAddT(newData);
      expect(notifier.state, isA<AsyncLoading>());
    });

    test(
        'Should return false sets state on error when start state is AsyncError',
        () async {
      final notifier = MockToggleMapNotifier();
      notifier.state = AsyncValue.error("test", StackTrace.current);
      final newData = MockT();
      await notifier.testAddT(newData);
      expect(notifier.state, isA<AsyncError>());
    });
  });

  group('Testing ToggleMapNotifier : addE', () {
    test(
        'Should returns true and updates state on success when value is AsyncData',
        () async {
      final notifier = MockToggleMapNotifier();
      final key = MockT();
      final data = <MockT, Tuple2<AsyncValue<List<MockE>>, bool>>{
        MockT(): Tuple2(AsyncValue.loading(), false),
        key: Tuple2(AsyncValue.data(<MockE>[]), false),
      };
      notifier.state = AsyncValue.data(data);
      final newData = MockE();
      final newDataList = [newData];
      final result = await notifier.testAddE(key, newData);
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>>());
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item1
              .when(
                data: (d) => d,
                error: (e, s) => [],
                loading: () => [],
              ),
          newDataList);
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item2,
          isFalse);
    });

    test(
        'Should returns true and updates state on success when value is AsyncLoading',
        () async {
      final notifier = MockToggleMapNotifier();
      final key = MockT();
      final data = <MockT, Tuple2<AsyncValue<List<MockE>>, bool>>{
        MockT(): Tuple2(AsyncValue.loading(), false),
        key: Tuple2(AsyncValue.loading(), true),
      };
      notifier.state = AsyncValue.data(data);
      final newData = MockE();
      final newDataList = [newData];
      final result = await notifier.testAddE(key, newData);
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>>());
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item1
              .when(
                data: (d) => d,
                error: (e, s) => [],
                loading: () => [],
              ),
          newDataList);
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item2,
          isTrue);
    });

    test(
        'Should returns true and updates state on success when value is AsyncError',
        () async {
      final notifier = MockToggleMapNotifier();
      final key = MockT();
      final data = <MockT, Tuple2<AsyncValue<List<MockE>>, bool>>{
        MockT(): Tuple2(AsyncValue.loading(), false),
        key: Tuple2(AsyncValue.error("test", StackTrace.current), false),
      };
      notifier.state = AsyncValue.data(data);
      final newData = MockE();
      final newDataList = [newData];
      final result = await notifier.testAddE(key, newData);
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>>());
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item1
              .when(
                data: (d) => d,
                error: (e, s) => [],
                loading: () => [],
              ),
          newDataList);
    });

    test(
        'Should return false sets state on error when start state is AsyncLoading',
        () async {
      final notifier = MockToggleMapNotifier();
      final key = MockT();
      final newData = MockE();
      final result = await notifier.testAddE(key, newData);
      expect(result, isFalse);
      expect(notifier.state, isA<AsyncError>());
      expect(notifier.state.error, "Cannot add while loading");
    });

    test(
        'Should return false sets state on error when start state is AsyncError',
        () async {
      final notifier = MockToggleMapNotifier();
      notifier.state = AsyncValue.error("test", StackTrace.current);
      final newData = MockE();
      final key = MockT();
      final result = await notifier.testAddE(key, newData);
      expect(result, isFalse);
      expect(notifier.state, isA<AsyncError>());
      expect(notifier.state.error, "test");
    });
  });

  group('Testing ToggleMapNotifier : deleteT', () {
    test('Should returns true and updates state', () async {
      final notifier = MockToggleMapNotifier();
      final key = MockT();
      final mockDataList = <MockE>[MockE(), MockE()];
      final endDataList = mockDataList.sublist(0, 1);
      final data = <MockT, Tuple2<AsyncValue<List<MockE>>, bool>>{
        MockT(): Tuple2(AsyncValue.loading(), false),
        key: Tuple2(AsyncValue.data(mockDataList), false),
      };
      notifier.state = AsyncValue.data(data);
      final result = await notifier.testDeleteT(key, 1);
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>>());
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item1
              .when(
                data: (d) => d,
                error: (e, s) => [],
                loading: () => [],
              ),
          endDataList);
    });

    test(
        'Should returns false and not updates state when index is greater than list length',
        () async {
      final notifier = MockToggleMapNotifier();
      final key = MockT();
      final mockDataList = <MockE>[MockE()];
      final data = <MockT, Tuple2<AsyncValue<List<MockE>>, bool>>{
        MockT(): Tuple2(AsyncValue.loading(), false),
        key: Tuple2(AsyncValue.data(mockDataList), false),
      };
      notifier.state = AsyncValue.data(data);
      final result = await notifier.testDeleteT(key, 1);
      expect(result, isFalse);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>>());
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item1
              .when(
                data: (d) => d,
                error: (e, s) => [],
                loading: () => [],
              ),
          mockDataList);
    });

    test(
        'Should return false sets state on error when start state is AsyncLoading',
        () async {
      final notifier = MockToggleMapNotifier();
      final key = MockT();
      final result = await notifier.testDeleteT(key, 0);
      expect(result, isFalse);
      expect(notifier.state, isA<AsyncError>());
      expect(notifier.state.error, "Cannot delete while loading");
    });

    test(
        'Should return false sets state on error when start state is AsyncError',
        () async {
      final notifier = MockToggleMapNotifier();
      notifier.state = AsyncValue.error("test", StackTrace.current);
      final key = MockT();
      final result = await notifier.testDeleteT(key, 0);
      expect(result, isFalse);
      expect(notifier.state, isA<AsyncError>());
      expect(notifier.state.error, "test");
    });
  });

  group('Testing ToggleMapNotifier : setTData', () {
    test('Should returns true and updates state', () async {
      final notifier = MockToggleMapNotifier();
      final key = MockT();
      final data = <MockT, Tuple2<AsyncValue<List<MockE>>, bool>>{
        MockT(): Tuple2(AsyncValue.loading(), false),
        key: Tuple2(AsyncValue.data(<MockE>[]), false),
      };
      final newData = AsyncValue.data([MockE()]);
      notifier.state = AsyncValue.data(data);
      final result = await notifier.testSetTData(key, newData);
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>>());
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item1,
          newData);
    });

    test('Should returns true and does not touch state when key is not in map',
        () async {
      final notifier = MockToggleMapNotifier();
      final key = MockT();
      final data = <MockT, Tuple2<AsyncValue<List<MockE>>, bool>>{
        MockT(): Tuple2(AsyncValue.loading(), false),
      };
      final newData = AsyncValue.data([MockE()]);
      notifier.state = AsyncValue.data(data);
      final result = await notifier.testSetTData(key, newData);
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncValue<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>>());
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item1,
          newData);
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item2,
          isFalse);
    });

    test(
        'Should return false sets state on error when start state is AsyncLoading',
        () async {
      final notifier = MockToggleMapNotifier();
      final key = MockT();
      final newData = AsyncValue.data([MockE()]);
      final result = await notifier.testSetTData(key, newData);
      expect(result, isFalse);
      expect(notifier.state, isA<AsyncError>());
      expect(notifier.state.error, "Cannot update while loading");
    });

    test(
        'Should return false sets state on error when start state is AsyncError',
        () async {
      final notifier = MockToggleMapNotifier();
      notifier.state = AsyncValue.error("test", StackTrace.current);
      final newData = AsyncValue.data([MockE()]);
      final key = MockT();
      final result = await notifier.testSetTData(key, newData);
      expect(result, isFalse);
      expect(notifier.state, isA<AsyncError>());
      expect(notifier.state.error, "test");
    });
  });

  group('Testing ToggleMapNotifier : toggleExpanded', () {
    test('Should returns true and updates state', () async {
      final notifier = MockToggleMapNotifier();
      final key = MockT();
      final newData = AsyncValue.data([MockE()]);
      final data = <MockT, Tuple2<AsyncValue<List<MockE>>, bool>>{
        MockT(): Tuple2(AsyncValue.loading(), false),
        key: Tuple2(newData, false),
      };
      notifier.state = AsyncValue.data(data);
      final result = await notifier.testToggleExpanded(key);
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>>());
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item1,
          newData);
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item2,
          isTrue);
    });

    test('Should returns true and updates state when is AsyncLoading',
        () async {
      final notifier = MockToggleMapNotifier();
      final key = MockT();
      final data = <MockT, Tuple2<AsyncValue<List<MockE>>, bool>>{
        MockT(): Tuple2(AsyncValue.loading(), false),
        key: Tuple2(AsyncValue.loading(), true),
      };
      notifier.state = AsyncValue.data(data);
      final result = await notifier.testToggleExpanded(key);
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>>());
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item1,
          isA<AsyncLoading>());
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item2,
          isFalse);
    });

    test('Should returns true and updates state when is AsyncError', () async {
      final notifier = MockToggleMapNotifier();
      final key = MockT();
      final data = <MockT, Tuple2<AsyncValue<List<MockE>>, bool>>{
        MockT(): Tuple2(AsyncValue.loading(), false),
        key: Tuple2(AsyncValue.error("test", StackTrace.current), true),
      };
      notifier.state = AsyncValue.data(data);
      final result = await notifier.testToggleExpanded(key);
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>>());
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item1,
          isA<AsyncError>());
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .item2,
          isFalse);
    });

    test('Should returns false and does not touch state when key is not in map',
        () async {
      final notifier = MockToggleMapNotifier();
      final key = MockT();
      final data = <MockT, Tuple2<AsyncValue<List<MockE>>, bool>>{
        MockT(): Tuple2(AsyncValue.loading(), false),
      };
      notifier.state = AsyncValue.data(data);
      final result = await notifier.testToggleExpanded(key);
      expect(result, isFalse);
      expect(notifier.state,
          isA<AsyncValue<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>>());
      expect(
          notifier.state
              .when<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})
              .keys
              .length,
          1);
    });

    test(
        'Should return false sets state on error when start state is AsyncLoading',
        () async {
      final notifier = MockToggleMapNotifier();
      final key = MockT();
      final result = await notifier.testToggleExpanded(key);
      expect(result, isFalse);
      expect(notifier.state,
          isA<AsyncValue<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>>());
    });

    test(
        'Should return false sets state on error when start state is AsyncError',
        () async {
      final notifier = MockToggleMapNotifier();
      notifier.state = AsyncValue.error("test", StackTrace.current);
      final key = MockT();
      final result = await notifier.testToggleExpanded(key);
      expect(result, isFalse);
      expect(notifier.state,
          isA<AsyncValue<Map<MockT, Tuple2<AsyncValue<List<MockE>>, bool>>>>());
    });
  });
}
