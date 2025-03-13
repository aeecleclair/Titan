import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class RecommendationLogoMapNotifier extends MapNotifier<Recommendation, Image> {
  RecommendationLogoMapNotifier() : super();
}

final recommendationLogoMapProvider = StateNotifierProvider<
    RecommendationLogoMapNotifier,
    Map<Recommendation, AsyncValue<List<Image>>?>>(
  (ref) {
    return RecommendationLogoMapNotifier();
  },
);
