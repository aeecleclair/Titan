import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/recommendation/adapters/recommendation.dart';
import 'package:myecl/recommendation/providers/recommendation_list_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;
import 'package:myecl/tools/builders/empty_models.dart';

class MockRecommendationRepository extends Mock implements Openapi {}

void main() {
  group('RecommendationListNotifier', () {
    late MockRecommendationRepository mockRepository;
    late RecommendationListNotifier provider;
    final recommendations = [
      EmptyModels.empty<Recommendation>().copyWith(id: '1'),
      EmptyModels.empty<Recommendation>().copyWith(id: '2'),
    ];
    final newRecommendation =
        EmptyModels.empty<Recommendation>().copyWith(id: '3');
    final updatedRecommendation =
        recommendations.first.copyWith(title: 'Updated Recommendation');

    setUp(() {
      mockRepository = MockRecommendationRepository();
      provider =
          RecommendationListNotifier(recommendationRepository: mockRepository);
    });

    test('loadRecommendation returns expected data', () async {
      when(() => mockRepository.recommendationRecommendationsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          recommendations,
        ),
      );

      final result = await provider.loadRecommendation();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        recommendations,
      );
    });

    test('loadRecommendation handles error', () async {
      when(() => mockRepository.recommendationRecommendationsGet())
          .thenThrow(Exception('Failed to load recommendations'));

      final result = await provider.loadRecommendation();

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });

    test('addRecommendation adds a recommendation to the list', () async {
      when(
        () => mockRepository.recommendationRecommendationsPost(
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          newRecommendation,
        ),
      );

      provider.state = AsyncValue.data([...recommendations]);
      final result = await provider
          .addRecommendation(newRecommendation.toRecommendationBase());

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [...recommendations, newRecommendation],
      );
    });

    test('addRecommendation handles error', () async {
      when(
        () => mockRepository.recommendationRecommendationsPost(
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to add recommendation'));

      provider.state = AsyncValue.data([...recommendations]);
      final result = await provider
          .addRecommendation(newRecommendation.toRecommendationBase());

      expect(result, false);
    });

    test('updateRecommendation updates a recommendation in the list', () async {
      when(
        () => mockRepository.recommendationRecommendationsRecommendationIdPatch(
          recommendationId: any(named: 'recommendationId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          updatedRecommendation,
        ),
      );

      provider.state = AsyncValue.data([...recommendations]);
      final result = await provider.updateRecommendation(updatedRecommendation);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [updatedRecommendation, ...recommendations.skip(1)],
      );
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

    test('deleteRecommendation removes a recommendation from the list',
        () async {
      when(
        () =>
            mockRepository.recommendationRecommendationsRecommendationIdDelete(
          recommendationId: any(named: 'recommendationId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      provider.state = AsyncValue.data([...recommendations]);
      final result =
          await provider.deleteRecommendation(recommendations.first.id);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        recommendations.skip(1).toList(),
      );
    });

    test('deleteRecommendation handles error', () async {
      when(
        () =>
            mockRepository.recommendationRecommendationsRecommendationIdDelete(
          recommendationId: recommendations.first.id,
        ),
      ).thenThrow(Exception('Failed to delete recommendation'));

      provider.state = AsyncValue.data([...recommendations]);
      final result =
          await provider.deleteRecommendation(recommendations.first.id);

      expect(result, false);
    });
  });
}
