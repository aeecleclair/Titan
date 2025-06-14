import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/logo_repository.dart';

class RecommendationLogoRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = "recommendation/recommendations";

  Future<Image> getRecommendationLogo(String id) async {
    final uint8List = await getLogo("", suffix: "/$id/picture");
    return Image.memory(uint8List);
  }

  Future<Image> addRecommendationLogo(Uint8List bytes, String id) async {
    final uint8List = await addLogo(bytes, "", suffix: "/$id/picture");
    return Image.memory(uint8List);
  }
}

final recommendationLogoRepositoryProvider =
    Provider<RecommendationLogoRepository>((ref) {
      final token = ref.watch(tokenProvider);
      return RecommendationLogoRepository()..setToken(token);
    });
