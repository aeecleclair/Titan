import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class RecommendationNotifier extends StateNotifier<Recommendation> {
  RecommendationNotifier() : super(EmptyModels.empty<Recommendation>());

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
