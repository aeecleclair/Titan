import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class RecommendationListNotifier extends ListNotifierAPI<Recommendation> {
  Openapi get recommendationRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<Recommendation>> build() {
    loadRecommendation();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<Recommendation>>> loadRecommendation() async {
    return await loadList(
      recommendationRepository.recommendationRecommendationsGet,
    );
  }

  Future<bool> addRecommendation(RecommendationBase recommendation) async {
    return await add(
      () => recommendationRepository.recommendationRecommendationsPost(
        body: recommendation,
      ),
      recommendation,
    );
  }

  Future<bool> updateRecommendation(Recommendation recommendation) async {
    return await update(
      () => recommendationRepository
          .recommendationRecommendationsRecommendationIdPatch(
            recommendationId: recommendation.id,
            body: RecommendationEdit(
              title: recommendation.title,
              description: recommendation.description,
              summary: recommendation.summary,
              code: recommendation.code,
            ),
          ),
      (recommendation) => recommendation.id,
      recommendation,
    );
  }

  Future<bool> deleteRecommendation(Recommendation recommendation) async {
    return await delete(
      () => recommendationRepository
          .recommendationRecommendationsRecommendationIdDelete(
            recommendationId: recommendation.id,
          ),
      (recommendation) => recommendation.id,
      recommendation.id,
    );
  }
}

final recommendationListProvider =
    NotifierProvider<
      RecommendationListNotifier,
      AsyncValue<List<Recommendation>>
    >(RecommendationListNotifier.new);
