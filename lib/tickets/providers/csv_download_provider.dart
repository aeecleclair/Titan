import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tickets/repositories/tickets_repository.dart';

class CsvDownloadNotifier extends StateNotifier<AsyncValue<void>> {
  final TicketsRepository _repository;
  CsvDownloadNotifier({required this._repository})
    : super(const AsyncValue.data(null));

  Future<Uint8List?> downloadCsv(String eventId) async {
    state = const AsyncValue.loading();
    try {
      final bytes = await _repository.downloadTicketsCsv(eventId);
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
      final repository = ref.watch(ticketsRepositoryProvider);
      return CsvDownloadNotifier(repository: repository);
    });
