import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/recommendation/class/recommendation.dart';
import 'package:titan/recommendation/providers/recommendation_list_provider.dart';
import 'package:titan/recommendation/repositories/recommendation_repository.dart';

class MockRecommendationRepository extends Mock
    implements RecommendationRepository {}

void main() {
  group('RoomListNotifier', () {
    test('Should load rooms', () async {
      final mockRecommendationRepository = MockRecommendationRepository();
      final newRecommendation = Recommendation.empty().copyWith(id: "1");
      when(
        () => mockRecommendationRepository.getRecommendationList(),
      ).thenAnswer((_) async => [newRecommendation]);
      final recommendationListProvider = RecommendationListNotifier(
        recommendationRepository: mockRecommendationRepository,
      );
      final recommendations = await recommendationListProvider
          .loadRecommendation();
      expect(recommendations, isA<AsyncData<List<Recommendation>>>());
      expect(
        recommendations
            .maybeWhen(data: (data) => data, orElse: () => [])
            .length,
        1,
      );
    });

    test('Should add a recommendation', () async {
      final mockRecommendationRepository = MockRecommendationRepository();
      final newRecommendation = Recommendation.empty().copyWith(id: "1");
      when(
        () => mockRecommendationRepository.getRecommendationList(),
      ).thenAnswer((_) async => [Recommendation.empty()]);
      when(
        () => mockRecommendationRepository.createRecommendation(
          newRecommendation,
        ),
      ).thenAnswer((_) async => newRecommendation);
      final recommendationListProvider = RecommendationListNotifier(
        recommendationRepository: mockRecommendationRepository,
      );
      await recommendationListProvider.loadRecommendation();
      final recommendation = await recommendationListProvider.addRecommendation(
        newRecommendation,
      );
      expect(recommendation, true);
    });

    test('Should update a recommendation', () async {
      final mockRecommendationRepository = MockRecommendationRepository();
      final newRecommendation = Recommendation.empty().copyWith(id: "1");
      when(
        () => mockRecommendationRepository.getRecommendationList(),
      ).thenAnswer((_) async => [Recommendation.empty(), newRecommendation]);
      when(
        () => mockRecommendationRepository.updateRecommendation(
          newRecommendation,
        ),
      ).thenAnswer((_) async => true);
      final recommendationListProvider = RecommendationListNotifier(
        recommendationRepository: mockRecommendationRepository,
      );
      await recommendationListProvider.loadRecommendation();
      final room = await recommendationListProvider.updateRecommendation(
        newRecommendation,
      );
      expect(room, true);
    });

    test('Should delete a recommendation', () async {
      final mockRecommendationRepository = MockRecommendationRepository();
      final newRecommendation = Recommendation.empty().copyWith(id: "1");
      when(
        () => mockRecommendationRepository.getRecommendationList(),
      ).thenAnswer((_) async => [Recommendation.empty(), newRecommendation]);
      when(
        () => mockRecommendationRepository.deleteRecommendation(
          newRecommendation.id!,
        ),
      ).thenAnswer((_) async => true);
      final roomListProvider = RecommendationListNotifier(
        recommendationRepository: mockRecommendationRepository,
      );
      await roomListProvider.loadRecommendation();
      final room = await roomListProvider.deleteRecommendation(
        newRecommendation,
      );
      expect(room, true);
    });
  });
}
