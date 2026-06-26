import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/vote/providers/result_provider.dart';

class MockResultRepository extends Mock implements Openapi {}

void main() {
  group('ResultNotifier', () {
    late MockResultRepository mockRepository;
    late ProviderContainer container;
    late ResultNotifier provider;
    final results = [
      AppModulesCampaignSchemasCampaignResult.empty().copyWith(listId: '1'),
      AppModulesCampaignSchemasCampaignResult.empty().copyWith(listId: '2'),
    ];

    setUp(() async {
      mockRepository = MockResultRepository();
      when(() => mockRepository.campaignResultsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('[]', 200),
          <AppModulesCampaignSchemasCampaignResult>[],
        ),
      );
      container = ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockRepository)],
      );
      provider = container.read(resultProvider.notifier);
      await Future(() {});
    });

    tearDown(() => container.dispose());

    test('loadResult returns expected data', () async {
      when(() => mockRepository.campaignResultsGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('body', 200), results),
      );

      final result = await provider.loadResult();

      expect(result.maybeWhen(data: (data) => data, orElse: () => []), results);
    });

    test('loadResult handles error', () async {
      when(
        () => mockRepository.campaignResultsGet(),
      ).thenThrow(Exception('Failed to load results'));

      final result = await provider.loadResult();

      expect(
        result.maybeWhen(error: (error, _) => error, orElse: () => null),
        isA<Exception>(),
      );
    });
  });
}
