import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/raffle/providers/tombola_logos_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/raffle/repositories/tombola_logo_repository.dart';

class TombolaLogoProvider extends SingleNotifier<Image> {
  final TombolaLogoRepository repository;
  final TombolaLogosNotifier tombolaLogosNotifier;
  TombolaLogoProvider({
    required this.tombolaLogosNotifier,
    required this.repository,
  }) : super(const AsyncValue.loading());

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
      final tombolaLogosNotifier = ref.watch(tombolaLogosProvider.notifier);
      final repository = TombolaLogoRepository(ref);
      return TombolaLogoProvider(
        tombolaLogosNotifier: tombolaLogosNotifier,
        repository: repository,
      );
    });
