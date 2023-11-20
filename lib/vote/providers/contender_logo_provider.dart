import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/vote/repositories/contender_logo_repository.dart';

class ContenderLogoProvider extends SingleNotifier<Image> {
  final ContenderLogoRepository contenderLogoRepository;
  ContenderLogoProvider({required this.contenderLogoRepository})
      : super(const AsyncValue.loading());

  Future<Image> getLogo(String id) async {
    return await contenderLogoRepository.getContenderLogo(id);
  }

  Future<Image> updateLogo(String id, Uint8List bytes) async {
    return await contenderLogoRepository.addContenderLogo(bytes, id);
  }
}

final contenderLogoProvider =
    StateNotifierProvider<ContenderLogoProvider, AsyncValue<Image>>((ref) {
  final contenderLogoRepository = ref.watch(contenderLogoRepositoryProvider);
  return ContenderLogoProvider(
      contenderLogoRepository: contenderLogoRepository);
});
