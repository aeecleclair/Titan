import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

class RecommendationLogoRepository {
  final Openapi client;
  RecommendationLogoRepository(this.client);

  Future<Image> getRecommendationLogo(String id) async {
    final response = await client
        .recommendationRecommendationsRecommendationIdPictureGet(
          recommendationId: id,
        );
    final bytes = response.bodyBytes;
    if (bytes.isEmpty) {
      return Image.asset(getTitanLogo());
    }
    return Image.memory(bytes);
  }

  Future<Image> addRecommendationLogo(Uint8List bytes, String id) async {
    await client.recommendationRecommendationsRecommendationIdPicturePost(
      recommendationId: id,
      image: bytes,
    );
    return Image.memory(bytes);
  }
}

final recommendationLogoRepositoryProvider =
    Provider<RecommendationLogoRepository>(
      (ref) => RecommendationLogoRepository(ref.watch(repositoryProvider)),
    );
