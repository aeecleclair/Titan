// Dans association_shotgun_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/repositories/shotgun_repository.dart';

// Provider family existant
final associationShotgunsProvider =
    FutureProvider.family<List<Shotgun>, String>((ref, associationId) async {
      final repository = ref.watch(shotgunRepositoryProvider);
      return await repository.getShotgunListByAssociationId(associationId);
    });

// NOUVEAU : Provider qui prend une association nullable
final selectedAssociationShotgunsProvider =
    FutureProvider.family<List<Shotgun>, String?>((ref, associationId) async {
      if (associationId == null) return [];
      final repository = ref.watch(shotgunRepositoryProvider);
      return await repository.getShotgunListByAssociationId(associationId);
    });
