import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/recommendation/class/recommendation.dart';
import 'package:myecl/recommendation/providers/recommendation_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class RecommendationLogoNotifier extends MapNotifier<Recommendation, Image> {
  RecommendationLogoNotifier() : super();
}

final recommendationLogoMapProvider = StateNotifierProvider<
    RecommendationLogoNotifier,
    AsyncValue<Map<Recommendation, AsyncValue<List<Image>>>>>(
  (ref) {
    RecommendationLogoNotifier recommendationLogoNotifier =
        RecommendationLogoNotifier();
    tokenExpireWrapperAuth(
      ref,
      () async {
        ref.watch(recommendationListProvider).maybeWhen(
          data: (data) {
            recommendationLogoNotifier.loadTList(data);
            return recommendationLogoNotifier;
          },
          orElse: () {
            recommendationLogoNotifier.loadTList([]);
            return recommendationLogoNotifier;
          },
        );
      },
    );
    return recommendationLogoNotifier;
  },
);
