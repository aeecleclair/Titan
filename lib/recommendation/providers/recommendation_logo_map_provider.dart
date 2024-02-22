import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/recommendation/class/recommendation.dart';
import 'package:myecl/recommendation/providers/recommendation_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class RecommendationLogoMapNotifier extends MapNotifier<Recommendation, Image> {
  RecommendationLogoMapNotifier() : super();
}

final recommendationLogoMapProvider = StateNotifierProvider<
    RecommendationLogoMapNotifier,
    AsyncValue<Map<Recommendation, AsyncValue<List<Image>>?>>>(
  (ref) {
    RecommendationLogoMapNotifier recommendationLogoMapNotifier =
        RecommendationLogoMapNotifier();
    tokenExpireWrapperAuth(
      ref,
      () async {
        ref.watch(recommendationListProvider).maybeWhen(
          data: (data) {
            recommendationLogoMapNotifier.loadTList(data);
            return recommendationLogoMapNotifier;
          },
          orElse: () {
            recommendationLogoMapNotifier.loadTList([]);
            return recommendationLogoMapNotifier;
          },
        );
      },
    );
    return recommendationLogoMapNotifier;
  },
);
