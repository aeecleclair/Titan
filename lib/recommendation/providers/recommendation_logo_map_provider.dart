import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/recommendation/class/recommendation.dart';

class RecommendationLogoMapNotifier
    extends Notifier<Map<Recommendation, Image>> {
  @override
  Map<Recommendation, Image> build() {
    return {};
  }
}

final recommendationLogoMapProvider =
    NotifierProvider<RecommendationLogoMapNotifier, Map<Recommendation, Image>>(
  () {
    return RecommendationLogoMapNotifier();
  },
);
