import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/shotgun/repositories/shotgun_repository.dart';

class CsvDownloadNotifier extends StateNotifier<AsyncValue<void>> {
  final ShotgunRepository shotgunRepository;
  CsvDownloadNotifier({required this.shotgunRepository})
    : super(const AsyncValue.data(null));

  Future<Uint8List?> downloadCsv(String eventId) async {
    state = const AsyncValue.loading();
    try {
      final bytes = await shotgunRepository.downloadTicketsCsv(eventId);
      state = const AsyncValue.data(null);
      return bytes;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }
}

final csvDownloadProvider =
    StateNotifierProvider<CsvDownloadNotifier, AsyncValue<void>>((ref) {
      final token = ref.watch(tokenProvider);
      final shotgunRepository = ShotgunRepository()..setToken(token);
      return CsvDownloadNotifier(shotgunRepository: shotgunRepository);
    });
