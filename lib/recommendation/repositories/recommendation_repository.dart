import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/recommendation/class/recommendation.dart';
import 'package:titan/tools/repository/repository.dart';

class RecommendationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'recommendation/recommendations';

  Future<List<Recommendation>> getRecommendationList() async {
    return List<Recommendation>.from(
      (await getList()).map((x) => Recommendation.fromJson(x)),
    );
  }

  Future<Recommendation> createRecommendation(
    Recommendation recommendation,
  ) async {
    return Recommendation.fromJson(await create(recommendation.toJson()));
  }

  Future<bool> updateRecommendation(Recommendation recommendation) async {
    return await update(recommendation.toJson(), "/${recommendation.id}");
  }

  Future<bool> deleteRecommendation(String recommendationId) async {
    return await delete("/$recommendationId");
  }
}

final recommendationRepositoryProvider = Provider<RecommendationRepository>((
  ref,
) {
  final token = ref.watch(tokenProvider);
  return RecommendationRepository()..setToken(token);
});
