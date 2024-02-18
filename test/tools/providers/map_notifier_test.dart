import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

  Future<bool> testAddE(MockT t, MockE e) async {
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
          isA<AsyncValue<Map<MockT, AsyncValue<List<MockE>>?>>>());
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
          isA<AsyncValue<List<MockE>>?>());
    });
  });

  group('Testing MapNotifier : addT', () {
    test('Should updates state on success', () async {
      final notifier = MockMapNotifier();
      final data = <MockT, AsyncValue<List<MockE>>?>{
        MockT(): const AsyncLoading(),
        MockT(): const AsyncValue.data(<MockE>[]),
      };
      notifier.state = AsyncValue.data(data);
      final newData = MockT();
      await notifier.testAddT(newData);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, AsyncValue<List<MockE>>?>>>());
      expect(
          notifier.state
              .when(data: (d) => d, error: (e, s) => {}, loading: () => {})
              .keys
              .contains(newData),
          isTrue);
      expect(
          notifier.state.when(
              data: (d) => d, error: (e, s) => {}, loading: () => {})[newData],
          isNull);
    });

    test('Should sets state on loading when start state is AsyncLoading',
        () async {
      final notifier = MockMapNotifier();
      final newData = MockT();
      await notifier.testAddT(newData);
      expect(notifier.state, isA<AsyncLoading>());
    });

    test(
        'Should return false sets state on error when start state is AsyncError',
        () async {
      final notifier = MockMapNotifier();
      notifier.state = AsyncValue.error("test", StackTrace.current);
      final newData = MockT();
      await notifier.testAddT(newData);
      expect(notifier.state, isA<AsyncError>());
    });
  });

  group('Testing MapNotifier : addE', () {
    test(
        'Should returns true and updates state on success when value is AsyncData',
        () async {
      final notifier = MockMapNotifier();
      final key = MockT();
      final data = <MockT, AsyncValue<List<MockE>>>{
        MockT(): const AsyncLoading(),
        key: const AsyncValue.data(<MockE>[])
      };
      notifier.state = AsyncValue.data(data);
      final newData = MockE();
      final newDataList = [newData];
      final result = await notifier.testAddE(key, newData);
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, AsyncValue<List<MockE>>?>>>());
      expect(
          notifier.state
              .when<Map<MockT, AsyncValue<List<MockE>>?>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .when(
                data: (d) => d,
                error: (e, s) => [],
                loading: () => [],
              ),
          newDataList);
    });

    test(
        'Should returns true and updates state on success when value is AsyncLoading',
        () async {
      final notifier = MockMapNotifier();
      final key = MockT();
      final data = <MockT, AsyncValue<List<MockE>>>{
        MockT(): const AsyncLoading(),
        key: const AsyncLoading()
      };
      notifier.state = AsyncValue.data(data);
      final newData = MockE();
      final newDataList = [newData];
      final result = await notifier.testAddE(key, newData);
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, AsyncValue<List<MockE>>?>>>());
      expect(
          notifier.state
              .when<Map<MockT, AsyncValue<List<MockE>>?>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
              .when(
                data: (d) => d,
                error: (e, s) => [],
                loading: () => [],
              ),
          newDataList);
    });

    test(
        'Should returns true and updates state on success when value is AsyncError',
        () async {
      final notifier = MockMapNotifier();
      final key = MockT();
      final data = <MockT, AsyncValue<List<MockE>>>{
        MockT(): const AsyncLoading(),
        key: AsyncError("test", StackTrace.current)
      };
      notifier.state = AsyncValue.data(data);
      final newData = MockE();
      final newDataList = [newData];
      final result = await notifier.testAddE(key, newData);
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, AsyncValue<List<MockE>>?>>>());
      expect(
          notifier.state
              .when<Map<MockT, AsyncValue<List<MockE>>?>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!
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
      final notifier = MockMapNotifier();
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
      final notifier = MockMapNotifier();
      notifier.state = AsyncValue.error("test", StackTrace.current);
      final newData = MockE();
      final key = MockT();
      final result = await notifier.testAddE(key, newData);
      expect(result, isFalse);
      expect(notifier.state, isA<AsyncError>());
      expect(notifier.state.error, "test");
    });
  });

  group('Testing MapNotifier : deleteT', () {
    test('Should returns true and updates state', () async {
      final notifier = MockMapNotifier();
      final key = MockT();
      final data = <MockT, AsyncValue<List<MockE>>>{
        MockT(): const AsyncLoading(),
        key: const AsyncValue.data(<MockE>[])
      };
      notifier.state = AsyncValue.data(data);
      final result = await notifier.testDeleteT(key);
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, AsyncValue<List<MockE>>?>>>());
      expect(
          notifier.state
              .when<Map<MockT, AsyncValue<List<MockE>>?>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})
              .keys
              .contains(key),
          isFalse);
    });

    test('Should returns true and does not touch state when key is not in map',
        () async {
      final notifier = MockMapNotifier();
      final key = MockT();
      final data = <MockT, AsyncValue<List<MockE>>>{
        MockT(): const AsyncLoading(),
        key: const AsyncLoading()
      };
      notifier.state = AsyncValue.data(data);
      final result = await notifier.testDeleteT(MockT());
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, AsyncValue<List<MockE>>?>>>());
      expect(
          notifier.state
              .when<Map<MockT, AsyncValue<List<MockE>>?>>(
                  data: (d) => d, error: (e, s) => {}, loading: () => {})
              .keys,
          data.keys);
    });

    test(
        'Should return false sets state on error when start state is AsyncLoading',
        () async {
      final notifier = MockMapNotifier();
      final key = MockT();
      final result = await notifier.testDeleteT(key);
      expect(result, isFalse);
      expect(notifier.state, isA<AsyncError>());
      expect(notifier.state.error, "Cannot delete while loading");
    });

    test(
        'Should return false sets state on error when start state is AsyncError',
        () async {
      final notifier = MockMapNotifier();
      notifier.state = AsyncValue.error("test", StackTrace.current);
      final key = MockT();
      final result = await notifier.testDeleteT(key);
      expect(result, isFalse);
      expect(notifier.state, isA<AsyncError>());
      expect(notifier.state.error, "test");
    });
  });

  group('Testing MapNotifier : setTData', () {
    test('Should returns true and updates state', () async {
      final notifier = MockMapNotifier();
      final key = MockT();
      final data = <MockT, AsyncValue<List<MockE>>>{
        MockT(): const AsyncLoading(),
        key: const AsyncValue.data(<MockE>[])
      };
      final newData = AsyncValue.data([MockE()]);
      notifier.state = AsyncValue.data(data);
      final result = await notifier.testSetTData(key, newData);
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, AsyncValue<List<MockE>>?>>>());
      expect(
          notifier.state.when<Map<MockT, AsyncValue<List<MockE>>?>>(
              data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!,
          newData);
    });

    test('Should returns true and does not touch state when key is not in map',
        () async {
      final notifier = MockMapNotifier();
      final key = MockT();
      final data = <MockT, AsyncValue<List<MockE>>>{
        MockT(): const AsyncLoading(),
      };
      final newData = AsyncValue.data([MockE()]);
      notifier.state = AsyncValue.data(data);
      final result = await notifier.testSetTData(key, newData);
      expect(result, isTrue);
      expect(notifier.state,
          isA<AsyncData<Map<MockT, AsyncValue<List<MockE>>?>>>());
      expect(
          notifier.state.when<Map<MockT, AsyncValue<List<MockE>>?>>(
              data: (d) => d, error: (e, s) => {}, loading: () => {})[key]!,
          newData);
    });

    test(
        'Should return false sets state on error when start state is AsyncLoading',
        () async {
      final notifier = MockMapNotifier();
      final key = MockT();
      final newData = AsyncValue.data([MockE()]);
      final result = await notifier.testSetTData(key, newData);
      expect(result, isFalse);
      expect(notifier.state, isA<AsyncError>());
      expect(notifier.state.error, "Cannot add while loading");
    });

    test(
        'Should return false sets state on error when start state is AsyncError',
        () async {
      final notifier = MockMapNotifier();
      notifier.state = const AsyncValue.error("test", StackTrace.empty);
      final newData = AsyncValue.data([MockE()]);
      final key = MockT();
      final result = await notifier.testSetTData(key, newData);
      expect(result, isFalse);
      expect(notifier.state, isA<AsyncError>());
      expect(notifier.state.error, "test");
    });
  });
}
