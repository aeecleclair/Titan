import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tombola/repositories/tombola_logo_repository.dart';

class TombolaLogoProvider extends SingleNotifier<Image> {
  final repository = TombolaLogoRepository();
  TombolaLogoProvider({required String token})
      : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<Image> getLogo(String id) async {

    Image logo = await repository.getTombolaLogo(id);
    state = AsyncValue.data(logo);
    return logo;
  }

  Future<Image> updateLogo(String id, String path) async {
    Image logo = await repository.addTombolaLogo(path, id);
    state = AsyncValue.data(logo);
    return logo;
  }
}

final tombolaLogoProvider =
    StateNotifierProvider<TombolaLogoProvider, AsyncValue<Image>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier =TombolaLogoProvider(token: token);
  return notifier;
});
