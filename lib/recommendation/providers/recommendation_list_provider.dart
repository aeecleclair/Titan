import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class RecommendationListNotifier extends ListNotifier2<Recommendation> {
  final Openapi recommendationRepository;
  RecommendationListNotifier({required this.recommendationRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Recommendation>>> loadRecommendation() async {
    return await loadList(
        recommendationRepository.recommendationRecommendationsGet);
  }

  Future<bool> addRecommendation(RecommendationBase recommendation) async {
    return await add(
      () => recommendationRepository.recommendationRecommendationsPost(
          body: recommendation),
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
              )),
      (recommendations, recommendation) => recommendations
        ..[recommendations.indexWhere((r) => r.id == recommendation.id)] =
            recommendation,
      recommendation,
    );
  }

  Future<bool> deleteRecommendation(Recommendation recommendation) async {
    return await delete(
      () => recommendationRepository
          .recommendationRecommendationsRecommendationIdDelete(
              recommendationId: recommendation.id),
      (recommendations, recommendation) =>
          recommendations..removeWhere((r) => r.id == recommendation.id),
      recommendation,
    );
  }
}

final recommendationListProvider = StateNotifierProvider<
    RecommendationListNotifier, AsyncValue<List<Recommendation>>>(
  (ref) {
    final recommendationRepository = ref.watch(repositoryProvider);
    //  rename
    final provider = RecommendationListNotifier(
      recommendationRepository: recommendationRepository,
    );
    tokenExpireWrapperAuth(
      ref,
      () async {
        await provider.loadRecommendation();
      },
    );
    return provider;
  },
);
