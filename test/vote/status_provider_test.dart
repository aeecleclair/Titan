import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/vote/providers/status_provider.dart';
import 'package:titan/vote/repositories/status_repository.dart';

class MockStatusRepository extends Mock implements StatusRepository {}

void main() {
  group('StatusNotifier', () {
    late StatusRepository statusRepository;
    late StatusNotifier statusNotifier;

    setUp(() {
      statusRepository = MockStatusRepository();
      statusNotifier = StatusNotifier(statusRepository: statusRepository);
    });

    test('initial state is loading', () {
      expect(statusNotifier.state, isA<AsyncValue<Status>>());
    });

    test('loadStatus returns status from repository', () async {
      const status = Status.waiting;
      when(() => statusRepository.getStatus()).thenAnswer((_) async => status);

      final result = await statusNotifier.loadStatus();

      expect(
        result.when(
          data: (data) => data,
          loading: () => Status.waiting,
          error: (_, _) => Status.waiting,
        ),
        status,
      );
    });

    test('openVote updates state to open if successful', () async {
      when(() => statusRepository.openVote()).thenAnswer((_) async => true);

      final result = await statusNotifier.openVote();

      expect(result, true);
      expect(statusNotifier.state, const AsyncData(Status.open));
    });

    test('openVote does not update state if unsuccessful', () async {
      when(() => statusRepository.openVote()).thenAnswer((_) async => false);

      final result = await statusNotifier.openVote();

      expect(result, false);
      expect(statusNotifier.state, isA<AsyncValue<Status>>());
    });

    test('closeVote updates state to closed if successful', () async {
      when(() => statusRepository.closeVote()).thenAnswer((_) async => true);

      final result = await statusNotifier.closeVote();

      expect(result, true);
      expect(statusNotifier.state, const AsyncData(Status.closed));
    });

    test('closeVote does not update state if unsuccessful', () async {
      when(() => statusRepository.closeVote()).thenAnswer((_) async => false);

      final result = await statusNotifier.closeVote();

      expect(result, false);
      expect(statusNotifier.state, isA<AsyncValue<Status>>());
    });

    test('countVote updates state to counting if successful', () async {
      when(() => statusRepository.countVote()).thenAnswer((_) async => true);

      final result = await statusNotifier.countVote();

      expect(result, true);
      expect(statusNotifier.state, const AsyncData(Status.counting));
    });

    test('countVote does not update state if unsuccessful', () async {
      when(() => statusRepository.countVote()).thenAnswer((_) async => false);

      final result = await statusNotifier.countVote();

      expect(result, false);
      expect(statusNotifier.state, isA<AsyncValue<Status>>());
    });

    test('resetVote updates state to waiting if successful', () async {
      when(() => statusRepository.resetVote()).thenAnswer((_) async => true);

      final result = await statusNotifier.resetVote();

      expect(result, true);
      expect(statusNotifier.state, const AsyncData(Status.waiting));
    });

    test('resetVote does not update state if unsuccessful', () async {
      when(() => statusRepository.resetVote()).thenAnswer((_) async => false);

      final result = await statusNotifier.resetVote();

      expect(result, false);
      expect(statusNotifier.state, isA<AsyncValue<Status>>());
    });

    test('publishVote updates state to published if successful', () async {
      when(() => statusRepository.publishVote()).thenAnswer((_) async => true);

      final result = await statusNotifier.publishVote();

      expect(result, true);
      expect(statusNotifier.state, const AsyncData(Status.published));
    });

    test('publishVote does not update state if unsuccessful', () async {
      when(() => statusRepository.publishVote()).thenAnswer((_) async => false);

      final result = await statusNotifier.publishVote();

      expect(result, false);
      expect(statusNotifier.state, isA<AsyncValue<Status>>());
    });
  });
}
