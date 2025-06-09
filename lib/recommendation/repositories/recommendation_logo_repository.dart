import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class RecommendationLogoRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = "recommendation/recommendations";

  RecommendationLogoRepository(super.ref);

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
      return RecommendationLogoRepository(ref)..setToken(token);
    });
