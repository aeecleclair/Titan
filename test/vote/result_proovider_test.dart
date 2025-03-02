import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/vote/providers/result_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;

class MockResultRepository extends Mock implements Openapi {}

void main() {
  group('ResultNotifier', () {
    late MockResultRepository mockRepository;
    late ResultNotifier provider;
    final results = [
      AppModulesCampaignSchemasCampaignResult.fromJson({})
          .copyWith(listId: '1'),
      AppModulesCampaignSchemasCampaignResult.fromJson({})
          .copyWith(listId: '2'),
    ];

    setUp(() {
      mockRepository = MockResultRepository();
      provider = ResultNotifier(resultRepository: mockRepository);
    });

    test('loadResult returns expected data', () async {
      when(() => mockRepository.campaignResultsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          results,
        ),
      );

      final result = await provider.loadResult();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        results,
      );
    });

    test('loadResult handles error', () async {
      when(() => mockRepository.campaignResultsGet())
          .thenThrow(Exception('Failed to load results'));

      final result = await provider.loadResult();

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });
  });
}
