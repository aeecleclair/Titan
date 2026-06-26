import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/repository/repository.dart';

class RecommendationLogoNotifier extends SingleNotifier<Image> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<Image> build() {
    return const AsyncValue.loading();
  }

  Future<Image> getRecommendationLogo(String id) async {
    final response = await repository
        .recommendationRecommendationsRecommendationIdPictureGet(
          recommendationId: id,
        );
    return response.bodyBytes.isEmpty
        ? Image.asset(getTitanLogo())
        : Image.memory(response.bodyBytes);
  }

  Future<Image> updateRecommendationLogo(String id, Uint8List bytes) async {
    await repository.recommendationRecommendationsRecommendationIdPicturePost(
      recommendationId: id,
      image: bytes,
    );
    return Image.memory(bytes);
  }
}

final recommendationLogoProvider =
    NotifierProvider<RecommendationLogoNotifier, AsyncValue<Image>>(
      RecommendationLogoNotifier.new,
    );
