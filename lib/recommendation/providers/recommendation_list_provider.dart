import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/recommendation/adapters/recommendation.dart';

class RecommendationListNotifier extends ListNotifierAPI<Recommendation> {
  final Openapi recommendationRepository;
  RecommendationListNotifier({required this.recommendationRepository})
      : super(const AsyncValue.loading());

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
        body: recommendation.toRecommendationEdit(),
      ),
      (recommendation) => recommendation.id,
      recommendation,
    );
  }

  Future<bool> deleteRecommendation(String recommendationId) async {
    return await delete(
      () => recommendationRepository
          .recommendationRecommendationsRecommendationIdDelete(
        recommendationId: recommendationId,
      ),
      (r) => r.id,
      recommendationId,
    );
  }
}

final recommendationListProvider = StateNotifierProvider<
    RecommendationListNotifier, AsyncValue<List<Recommendation>>>(
  (ref) {
    final recommendationRepository = ref.watch(repositoryProvider);
    return RecommendationListNotifier(
      recommendationRepository: recommendationRepository,
    )..loadRecommendation();
  },
);
