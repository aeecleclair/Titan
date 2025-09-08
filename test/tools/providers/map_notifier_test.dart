import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/providers/map_provider.dart';

class MockE {}

class MockT {}

class MockMapNotifier extends MapNotifier<MockT, MockE> {
  MockMapNotifier() : super();

  void testLoadTlist(List<MockT> tList) async {
    return loadTList(tList);
  }

  void testAddT(MockT t) async {
    return addT(t);
  }

  void testAddE(MockT t, MockE e) {
    return addE(t, e);
  }

  void testDeleteT(MockT t) {
    return deleteT(t);
  }

  void testSetTData(MockT t, AsyncValue<List<MockE>> asyncEList) async {
    return setTData(t, asyncEList);
  }
}

void main() {
  group('Testing MapNotifier : loadTList', () {
    test('Should initiate to AsyncLoading', () {
      final notifier = MockMapNotifier();
      expect(notifier.state, isA<Map>());
    });

    test('Should state be AsyncData when loading data', () async {
      final notifier = MockMapNotifier();
      final data = [MockT(), MockT()];
      notifier.testLoadTlist(data);
      expect(notifier.state, isA<Map<MockT, AsyncValue<List<MockE>>?>>());
      expect(notifier.state.keys.toList(), data);
      expect(notifier.state.values.first, isA<AsyncValue<List<MockE>>?>());
    });
  });

  group('Testing MapNotifier : addT', () {
    test('Should updates state on success', () async {
      final notifier = MockMapNotifier();
      final data = <MockT, AsyncValue<List<MockE>>?>{
        MockT(): const AsyncLoading(),
        MockT(): const AsyncValue.data(<MockE>[]),
      };
      notifier.state = data;
      final newData = MockT();
      notifier.testAddT(newData);
      expect(notifier.state, isA<Map<MockT, AsyncValue<List<MockE>>?>>());
      expect(notifier.state.keys.contains(newData), isTrue);
    });

    test(
      'Should sets state on loading when start state is AsyncLoading',
      () async {
        final notifier = MockMapNotifier();
        final newData = MockT();
        notifier.testAddT(newData);
        expect(notifier.state, isA<Map>());
      },
    );
  });

  group('Testing MapNotifier : addE', () {
    test(
      'Should returns true and updates state on success when value is AsyncData',
      () async {
        final notifier = MockMapNotifier();
        final key = MockT();
        final data = <MockT, AsyncValue<List<MockE>>>{
          MockT(): const AsyncLoading(),
          key: const AsyncValue.data(<MockE>[]),
        };
        notifier.state = data;
        final newData = MockE();
        final newDataList = [newData];
        notifier.testAddE(key, newData);
        expect(notifier.state, isA<Map<MockT, AsyncValue<List<MockE>>?>>());
        expect(
          notifier.state[key]!.when(
            data: (d) => d,
            error: (e, s) => [],
            loading: () => [],
          ),
          newDataList,
        );
      },
    );

    test(
      'Should returns true and updates state on success when value is AsyncLoading',
      () async {
        final notifier = MockMapNotifier();
        final key = MockT();
        final data = <MockT, AsyncValue<List<MockE>>>{
          MockT(): const AsyncLoading(),
          key: const AsyncLoading(),
        };
        notifier.state = data;
        final newData = MockE();
        final newDataList = [newData];
        notifier.testAddE(key, newData);
        expect(notifier.state, isA<Map<MockT, AsyncValue<List<MockE>>?>>());
        expect(
          notifier.state[key]!.when(
            data: (d) => d,
            error: (e, s) => [],
            loading: () => [],
          ),
          newDataList,
        );
      },
    );

    test(
      'Should returns true and updates state on success when value is AsyncError',
      () async {
        final notifier = MockMapNotifier();
        final key = MockT();
        final data = <MockT, AsyncValue<List<MockE>>>{
          MockT(): const AsyncLoading(),
          key: AsyncError("test", StackTrace.current),
        };
        notifier.state = data;
        final newData = MockE();
        final newDataList = [newData];
        notifier.testAddE(key, newData);
        expect(notifier.state, isA<Map<MockT, AsyncValue<List<MockE>>?>>());
        expect(
          notifier.state[key]!.when(
            data: (d) => d,
            error: (e, s) => [],
            loading: () => [],
          ),
          newDataList,
        );
      },
    );
  });

  group('Testing MapNotifier : deleteT', () {
    test('Should returns true and updates state', () async {
      final notifier = MockMapNotifier();
      final key = MockT();
      final data = <MockT, AsyncValue<List<MockE>>>{
        MockT(): const AsyncLoading(),
        key: const AsyncValue.data(<MockE>[]),
      };
      notifier.state = data;
      notifier.testDeleteT(key);
      expect(notifier.state, isA<Map<MockT, AsyncValue<List<MockE>>?>>());
      expect(notifier.state.keys.contains(key), isFalse);
    });

    test(
      'Should returns true and does not touch state when key is not in map',
      () async {
        final notifier = MockMapNotifier();
        final key = MockT();
        final data = <MockT, AsyncValue<List<MockE>>>{
          MockT(): const AsyncLoading(),
          key: const AsyncLoading(),
        };
        notifier.state = data;
        notifier.testDeleteT(MockT());
        expect(notifier.state, isA<Map<MockT, AsyncValue<List<MockE>>?>>());
        expect(notifier.state.keys, data.keys);
      },
    );
  });

  group('Testing MapNotifier : setTData', () {
    test('Should returns true and updates state', () async {
      final notifier = MockMapNotifier();
      final key = MockT();
      final data = <MockT, AsyncValue<List<MockE>>>{
        MockT(): const AsyncLoading(),
        key: const AsyncValue.data(<MockE>[]),
      };
      final newData = AsyncValue.data([MockE()]);
      notifier.state = data;
      notifier.testSetTData(key, newData);
      expect(notifier.state, isA<Map<MockT, AsyncValue<List<MockE>>?>>());
      expect(notifier.state[key]!, newData);
    });

    test(
      'Should returns true and does not touch state when key is not in map',
      () async {
        final notifier = MockMapNotifier();
        final key = MockT();
        final data = <MockT, AsyncValue<List<MockE>>>{
          MockT(): const AsyncLoading(),
        };
        final newData = AsyncValue.data([MockE()]);
        notifier.state = data;
        notifier.testSetTData(key, newData);
        expect(notifier.state, isA<Map<MockT, AsyncValue<List<MockE>>?>>());
        expect(notifier.state[key]!, newData);
      },
    );
  });
}
