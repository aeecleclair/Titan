import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/recommendation/class/recommendation.dart';
import 'package:titan/recommendation/repositories/recommendation_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class RecommendationListNotifier extends ListNotifier<Recommendation> {
  final RecommendationRepository recommendationRepository;

  RecommendationListNotifier({required this.recommendationRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Recommendation>>> loadRecommendation() async {
    return await loadList(recommendationRepository.getRecommendationList);
  }

  Future<bool> addRecommendation(Recommendation recommendation) async {
    return await add(
      recommendationRepository.createRecommendation,
      recommendation,
    );
  }

  Future<bool> updateRecommendation(Recommendation recommendation) async {
    return await update(
      recommendationRepository.updateRecommendation,
      (recommendations, recommendation) => recommendations
        ..[recommendations.indexWhere((r) => r.id == recommendation.id)] =
            recommendation,
      recommendation,
    );
  }

  Future<bool> deleteRecommendation(Recommendation recommendation) async {
    return await delete(
      recommendationRepository.deleteRecommendation,
      (recommendations, recommendation) =>
          recommendations..removeWhere((r) => r.id == recommendation.id),
      recommendation.id!,
      recommendation,
    );
  }
}

final recommendationListProvider =
    StateNotifierProvider<
      RecommendationListNotifier,
      AsyncValue<List<Recommendation>>
    >((ref) {
      final recommendatioRepository = ref.watch(
        recommendationRepositoryProvider,
      );
      final provider = RecommendationListNotifier(
        recommendationRepository: recommendatioRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadRecommendation();
      });
      return provider;
    });
