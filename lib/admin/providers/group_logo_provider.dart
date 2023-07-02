import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/repositories/group_logo_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class GroupLogoNotifier extends SingleNotifier<Image> {
  final repository = GroupLogoRepository();
  GroupLogoNotifier({required String token})
      : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<Image> getLogo(String id) async {
    final bytes = await repository.getLogo(id, suffix: "/logo");
    if (bytes.isEmpty) {
      return Image.asset("assets/images/logo.png");
    }
    return Image.memory(bytes);
  }

  Future<Image> updateLogo(String id, Uint8List bytes) async {
    return Image.memory(await repository.addLogo(bytes, id, suffix: "/logo"));
  }
}

final groupLogoProvider =
StateNotifierProvider<GroupLogoNotifier, AsyncValue<Image>>((ref) {
  final token = ref.watch(tokenProvider);
  return GroupLogoNotifier(token: token);
});
