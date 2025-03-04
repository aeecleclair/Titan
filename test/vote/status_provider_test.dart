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
    final status = VoteStatus(status: StatusType.open);

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
  });
}
