import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/vote/repositories/contender_logo_repository.dart';

class ContenderLogoProvider extends SingleNotifier<Image> {
  final repository = ContenderLogoRepository();
  ContenderLogoProvider({required String token})
      : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<Image> getLogo(String id) async {
    return await repository.getContenderLogo(id);
  }

  Future<Image> updateLogo(String id, Uint8List bytes) async {
    return await repository.addContenderLogo(bytes, id);
  }
}

final contenderLogoProvider =
    StateNotifierProvider<ContenderLogoProvider, AsyncValue<Image>>((ref) {
  final token = ref.watch(tokenProvider);
  return ContenderLogoProvider(token: token);
});
