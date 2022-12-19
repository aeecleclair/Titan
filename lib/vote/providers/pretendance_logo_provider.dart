import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/vote/repositories/pretendance_logo_repository.dart';

class PretendenceLogoProovider extends SingleNotifier<Image> {
  final repository = PretendanceLogoRepository();
  PretendenceLogoProovider({required String token})
      : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<Image> getLogo(String id) async {
    return await repository.getPretendenceLogo(id);
  }

  Future<Image> updateLogo(String id, String path) async {
    return await repository.addPretendenceLogo(path, id);
  }
}

final pretendenceLogoProvider =
    StateNotifierProvider<PretendenceLogoProovider, AsyncValue<Image>>((ref) {
  final token = ref.watch(tokenProvider);
  return PretendenceLogoProovider(token: token);
});
