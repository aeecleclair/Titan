import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/vote/providers/contender_logos_provider.dart';
import 'package:myecl/vote/repositories/contender_logo_repository.dart';

class ContenderLogoProvider extends SingleNotifier<Image> {
  final ContenderLogoRepository contenderLogoRepository;
  final ContenderLogoNotifier contenderLogosNotifier;
  ContenderLogoProvider({
    required this.contenderLogoRepository,
    required this.contenderLogosNotifier,
  }) : super(const AsyncValue.loading());

  Future<Image> getLogo(String id) async {
    return await contenderLogoRepository.getContenderLogo(id).then((image) {
      contenderLogosNotifier.setTData(id, AsyncData([image]));
      return image;
    });
  }

  Future<Image> updateLogo(String id, Uint8List bytes) async {
    final image = await contenderLogoRepository.addContenderLogo(bytes, id);
    contenderLogosNotifier.setTData(id, AsyncData([image]));
    return image;
  }
}

final contenderLogoProvider =
    StateNotifierProvider<ContenderLogoProvider, AsyncValue<Image>>((ref) {
      final contenderLogoRepository = ContenderLogoRepository(ref);
      final contenderLogosNotifier = ref.watch(contenderLogosProvider.notifier);
      return ContenderLogoProvider(
        contenderLogoRepository: contenderLogoRepository,
        contenderLogosNotifier: contenderLogosNotifier,
      );
    });
