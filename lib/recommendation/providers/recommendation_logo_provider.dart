import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/recommendation/repositories/recommendation_logo_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class RecommendationLogoNotifier extends SingleNotifier<Image> {
  final RecommendationLogoRepository recommendationLogoRepository;
  RecommendationLogoNotifier({required this.recommendationLogoRepository})
    : super(const AsyncValue.loading());

  Future<Image> getRecommendationLogo(String id) async {
    return await recommendationLogoRepository.getRecommendationLogo(id);
  }

  Future<Image> updateRecommendationLogo(String id, Uint8List bytes) async {
    return await recommendationLogoRepository.addRecommendationLogo(bytes, id);
  }
}

final recommendationLogoProvider =
    StateNotifierProvider<RecommendationLogoNotifier, AsyncValue<Image>>((ref) {
      final recommendationLogoRepository = ref.watch(
        recommendationLogoRepositoryProvider,
      );
      return RecommendationLogoNotifier(
        recommendationLogoRepository: recommendationLogoRepository,
      );
    });
