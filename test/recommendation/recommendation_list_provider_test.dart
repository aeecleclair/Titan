import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/recommendation/adapters/recommendation.dart';
import 'package:titan/recommendation/providers/recommendation_list_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;
import 'package:titan/tools/repository/repository.dart';

class MockRecommendationRepository extends Mock implements Openapi {}

void main() {
  group('RecommendationListNotifier', () {
    late MockRecommendationRepository mockRepository;
    late ProviderContainer container;
    late RecommendationListNotifier provider;
    final recommendations = [
      Recommendation.empty().copyWith(id: '1'),
      Recommendation.empty().copyWith(id: '2'),
    ];
    final newRecommendation = Recommendation.empty().copyWith(id: '3');
    final updatedRecommendation = recommendations.first.copyWith(
      title: 'Updated Recommendation',
    );

    setUp(() async {
      mockRepository = MockRecommendationRepository();
      // Default stub for the build()-time auto-load.
      when(() => mockRepository.recommendationRecommendationsGet()).thenAnswer(
        (_) async =>
            chopper.Response(http.Response('[]', 200), <Recommendation>[]),
      );
      container = ProviderContainer(
        overrides: [repositoryProvider.overrideWithValue(mockRepository)],
      );
      provider = container.read(recommendationListProvider.notifier);
      await Future(() {});
    });

    tearDown(() => container.dispose());

    test('loadRecommendation returns expected data', () async {
      when(() => mockRepository.recommendationRecommendationsGet()).thenAnswer(
        (_) async =>
            chopper.Response(http.Response('body', 200), recommendations),
      );

      final result = await provider.loadRecommendation();

      expect(
        result.maybeWhen(data: (data) => data, orElse: () => []),
        recommendations,
      );
    });

    test('loadRecommendation handles error', () async {
      when(
        () => mockRepository.recommendationRecommendationsGet(),
      ).thenThrow(Exception('Failed to load recommendations'));

      final result = await provider.loadRecommendation();

      expect(
        result.maybeWhen(error: (error, _) => error, orElse: () => null),
        isA<Exception>(),
      );
    });

    test('addRecommendation adds a recommendation to the list', () async {
      when(() => mockRepository.recommendationRecommendationsGet()).thenAnswer(
        (_) async =>
            chopper.Response(http.Response('body', 200), recommendations),
      );
      when(
        () => mockRepository.recommendationRecommendationsPost(
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async =>
            chopper.Response(http.Response('body', 200), newRecommendation),
      );

      provider.state = AsyncValue.data([...recommendations]);
      final result = await provider.addRecommendation(
        newRecommendation.toRecommendationBase(),
      );

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        ...recommendations,
        newRecommendation,
      ]);
    });

    test('addRecommendation handles error', () async {
      when(
        () => mockRepository.recommendationRecommendationsPost(
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to add recommendation'));

      provider.state = AsyncValue.data([...recommendations]);
      final result = await provider.addRecommendation(
        newRecommendation.toRecommendationBase(),
      );

      expect(result, false);
    });

    test('updateRecommendation updates a recommendation in the list', () async {
      when(() => mockRepository.recommendationRecommendationsGet()).thenAnswer(
        (_) async =>
            chopper.Response(http.Response('body', 200), recommendations),
      );
      when(
        () => mockRepository.recommendationRecommendationsRecommendationIdPatch(
          recommendationId: any(named: 'recommendationId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async =>
            chopper.Response(http.Response('body', 200), updatedRecommendation),
      );

      provider.state = AsyncValue.data([...recommendations]);
      final result = await provider.updateRecommendation(updatedRecommendation);

      expect(result, true);
      expect(provider.state.maybeWhen(data: (data) => data, orElse: () => []), [
        updatedRecommendation,
        ...recommendations.skip(1),
      ]);
    });

    test('updateRecommendation handles error', () async {
      when(
        () => mockRepository.recommendationRecommendationsRecommendationIdPatch(
          recommendationId: any(named: 'recommendationId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to update recommendation'));

      provider.state = AsyncValue.data([...recommendations]);
      final result = await provider.updateRecommendation(updatedRecommendation);

      expect(result, false);
    });

    test(
      'deleteRecommendation removes a recommendation from the list',
      () async {
        when(
          () => mockRepository.recommendationRecommendationsGet(),
        ).thenAnswer(
          (_) async =>
              chopper.Response(http.Response('body', 200), recommendations),
        );
        when(
          () => mockRepository
              .recommendationRecommendationsRecommendationIdDelete(
                recommendationId: any(named: 'recommendationId'),
              ),
        ).thenAnswer(
          (_) async => chopper.Response(http.Response('body', 200), null),
        );

        provider.state = AsyncValue.data([...recommendations]);
        final result = await provider.deleteRecommendation(
          recommendations.first,
        );

        expect(result, true);
        expect(
          provider.state.maybeWhen(data: (data) => data, orElse: () => []),
          recommendations.skip(1).toList(),
        );
      },
    );

    test('deleteRecommendation handles error', () async {
      when(
        () =>
            mockRepository.recommendationRecommendationsRecommendationIdDelete(
              recommendationId: recommendations.first.id,
            ),
      ).thenThrow(Exception('Failed to delete recommendation'));

      provider.state = AsyncValue.data([...recommendations]);
      final result = await provider.deleteRecommendation(recommendations.first);

      expect(result, false);
    });
  });
}
