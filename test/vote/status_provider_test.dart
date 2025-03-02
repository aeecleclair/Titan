import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;

class MockStatusRepository extends Mock implements Openapi {}

void main() {
  group('StatusNotifier', () {
    late MockStatusRepository mockRepository;
    late StatusNotifier provider;
    final status = VoteStatus.fromJson({}).copyWith(status: StatusType.open);

    setUp(() {
      mockRepository = MockStatusRepository();
      provider = StatusNotifier(statusRepository: mockRepository);
    });

    test('loadStatus returns expected data', () async {
      when(() => mockRepository.campaignStatusGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          status,
        ),
      );

      final result = await provider.loadStatus();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => null,
        ),
        status,
      );
    });

    test('loadStatus handles error', () async {
      when(() => mockRepository.campaignStatusGet())
          .thenThrow(Exception('Failed to load status'));

      final result = await provider.loadStatus();

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });

    test('openVote updates state to open if successful', () async {
      when(() => mockRepository.campaignStatusOpenPost()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      final result = await provider.openVote();

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data.status,
          orElse: () => null,
        ),
        StatusType.open,
      );
    });

    test('openVote handles error', () async {
      when(() => mockRepository.campaignStatusOpenPost())
          .thenThrow(Exception('Failed to open vote'));

      final result = await provider.openVote();

      expect(result, false);
    });

    test('closeVote updates state to closed if successful', () async {
      when(() => mockRepository.campaignStatusClosePost()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      final result = await provider.closeVote();

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data.status,
          orElse: () => null,
        ),
        StatusType.closed,
      );
    });

    test('closeVote handles error', () async {
      when(() => mockRepository.campaignStatusClosePost())
          .thenThrow(Exception('Failed to close vote'));

      final result = await provider.closeVote();

      expect(result, false);
    });

    test('countVote updates state to counting if successful', () async {
      when(() => mockRepository.campaignStatusCountingPost()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      final result = await provider.countVote();

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data.status,
          orElse: () => null,
        ),
        StatusType.counting,
      );
    });

    test('countVote handles error', () async {
      when(() => mockRepository.campaignStatusCountingPost())
          .thenThrow(Exception('Failed to count vote'));

      final result = await provider.countVote();

      expect(result, false);
    });

    test('resetVote updates state to waiting if successful', () async {
      when(() => mockRepository.campaignStatusResetPost()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      final result = await provider.resetVote();

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data.status,
          orElse: () => null,
        ),
        StatusType.waiting,
      );
    });

    test('resetVote handles error', () async {
      when(() => mockRepository.campaignStatusResetPost())
          .thenThrow(Exception('Failed to reset vote'));

      final result = await provider.resetVote();

      expect(result, false);
    });

    test('publishVote updates state to published if successful', () async {
      when(() => mockRepository.campaignStatusPublishedPost()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      final result = await provider.publishVote();

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data.status,
          orElse: () => null,
        ),
        StatusType.published,
      );
    });

    test('publishVote handles error', () async {
      when(() => mockRepository.campaignStatusPublishedPost())
          .thenThrow(Exception('Failed to publish vote'));

      final result = await provider.publishVote();

      expect(result, false);
    });
  });
}
