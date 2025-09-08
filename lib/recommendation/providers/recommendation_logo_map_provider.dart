import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/recommendation/class/recommendation.dart';
import 'package:titan/tools/providers/map_provider.dart';

class RecommendationLogoMapNotifier extends MapNotifier<Recommendation, Image> {
  RecommendationLogoMapNotifier() : super();
}

final recommendationLogoMapProvider =
    StateNotifierProvider<
      RecommendationLogoMapNotifier,
      Map<Recommendation, AsyncValue<List<Image>>?>
    >((ref) {
      return RecommendationLogoMapNotifier();
    });
