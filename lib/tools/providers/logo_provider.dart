import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/logo_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class LogoNotifier extends SingleNotifier<Image> {
  final repository = LogoRepository();
  LogoNotifier({required String token}) : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<Image> getLogo(String id) async {
    return await repository.getLogo(id);
  }

  Future<Image> updateLogo(String id, String path) async {
    return await repository.addLogo(path, id);
  }
}

final logoProvider = StateNotifierProvider<LogoNotifier, AsyncValue<Image>>(
    (ref) {
  final token = ref.watch(tokenProvider);
  return LogoNotifier(token: token);;
});