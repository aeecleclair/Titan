import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/recommendation/class/recommendation.dart';

class RecommendationNotifier extends StateNotifier<Recommendation> {
  RecommendationNotifier() : super(Recommendation.empty());

  void setRecommendation(Recommendation r) {
    state = r;
  }
}

final recommendationProvider =
    StateNotifierProvider<RecommendationNotifier, Recommendation>((ref) {
      return RecommendationNotifier();
    });
