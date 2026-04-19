import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tickets/repositories/ticket_event_repository.dart';

class CsvDownloadNotifier extends StateNotifier<AsyncValue<void>> {
  final TicketEventRepository ticketEventRepository;
  CsvDownloadNotifier({required this.ticketEventRepository})
    : super(const AsyncValue.data(null));

  Future<Uint8List?> downloadCsv(String eventId) async {
    state = const AsyncValue.loading();
    try {
      final bytes = await ticketEventRepository.downloadTicketsCsv(eventId);
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
      final ticketEventRepository = TicketEventRepository()..setToken(token);
      return CsvDownloadNotifier(ticketEventRepository: ticketEventRepository);
    });
