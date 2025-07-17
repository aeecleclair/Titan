import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/repositories/group_logo_repository.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class GroupLogoNotifier extends SingleNotifier<Image> {
  final GroupLogoRepository groupLogoRepository;
  GroupLogoNotifier({required this.groupLogoRepository})
    : super(const AsyncValue.loading());

  Future<Image> getLogo(String id) async {
    final bytes = await groupLogoRepository.getLogo(id, suffix: "/logo");
    if (bytes.isEmpty) {
      return Image.asset(getTitanLogo());
    }
    return Image.memory(bytes);
  }

  Future<Image> updateLogo(String id, Uint8List bytes) async {
    return Image.memory(
      await groupLogoRepository.addLogo(bytes, id, suffix: "/logo"),
    );
  }
}

final groupLogoProvider =
    StateNotifierProvider<GroupLogoNotifier, AsyncValue<Image>>((ref) {
      final groupLogoRepository = GroupLogoRepository();
      return GroupLogoNotifier(groupLogoRepository: groupLogoRepository);
    });
