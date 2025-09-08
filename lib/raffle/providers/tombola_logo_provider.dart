import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/raffle/providers/tombola_logos_provider.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/raffle/repositories/tombola_logo_repository.dart';

class TombolaLogoProvider extends SingleNotifier<Image> {
  final repository = TombolaLogoRepository();
  final TombolaLogosNotifier tombolaLogosNotifier;
  TombolaLogoProvider({
    required String token,
    required this.tombolaLogosNotifier,
  }) : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<Image> getLogo(String id) async {
    Image logo = await repository.getTombolaLogo(id);
    tombolaLogosNotifier.setTData(id, AsyncData([logo]));
    state = AsyncValue.data(logo);
    return logo;
  }

  Future<Image> updateLogo(String id, Uint8List bytes) async {
    Image logo = await repository.addTombolaLogo(bytes, id);
    tombolaLogosNotifier.setTData(id, AsyncData([logo]));
    state = AsyncValue.data(logo);
    return logo;
  }
}

final tombolaLogoProvider =
    StateNotifierProvider<TombolaLogoProvider, AsyncValue<Image>>((ref) {
      final token = ref.watch(tokenProvider);
      final tombolaLogosNotifier = ref.watch(tombolaLogosProvider.notifier);
      return TombolaLogoProvider(
        token: token,
        tombolaLogosNotifier: tombolaLogosNotifier,
      );
    });
