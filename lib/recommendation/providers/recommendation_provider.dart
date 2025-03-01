import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class RecommendationNotifier extends StateNotifier<Recommendation> {
  RecommendationNotifier() : super(Recommendation.fromJson({}));

  void setRecommendation(Recommendation r) {
    state = r;
  }
}

final recommendationProvider =
    StateNotifierProvider<RecommendationNotifier, Recommendation>(
  (ref) {
    return RecommendationNotifier();
  },
);
