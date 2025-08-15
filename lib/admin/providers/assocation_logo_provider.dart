import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/association_logo_list.dart';
import 'package:titan/admin/repositories/association_logo_repository.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class AssociationLogoNotifier extends SingleNotifier<Image> {
  final associationLogoRepository = AssociationLogoRepository();
  final AssociationLogoListNotifier associationLogoListNotifier;
  AssociationLogoNotifier({
    required String token,
    required this.associationLogoListNotifier,
  }) : super(const AsyncValue.loading()) {
    associationLogoRepository.setToken(token);
  }

  Future<Image> getAssociationLogo(String id) async {
    final image = await associationLogoRepository.getAssociationLogo(id);
    associationLogoListNotifier.setTData(id, AsyncData([image]));
    return image;
  }

  Future<Image> updateAssociationLogo(String id, Uint8List bytes) async {
    associationLogoListNotifier.setTData(id, const AsyncLoading());
    final image = await associationLogoRepository.addAssociationLogo(bytes, id);
    associationLogoListNotifier.setTData(id, AsyncData([image]));
    return image;
  }
}

final associationLogoProvider =
    StateNotifierProvider<AssociationLogoNotifier, AsyncValue<Image>>((ref) {
      final token = ref.watch(tokenProvider);
      final associationLogoListNotifier = ref.watch(
        associationLogoListProvider.notifier,
      );
      return AssociationLogoNotifier(
        token: token,
        associationLogoListNotifier: associationLogoListNotifier,
      );
    });
