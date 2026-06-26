import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class CsvDownloadNotifier extends Notifier<AsyncValue<void>> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<Uint8List?> downloadCsv(String eventId) async {
    state = const AsyncValue.loading();
    try {
      final response = await repository.ticketsAdminEventsEventIdTicketsCsvGet(
        eventId: eventId,
      );
      state = const AsyncValue.data(null);
      return response.bodyBytes;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }
}

final csvDownloadProvider =
    NotifierProvider<CsvDownloadNotifier, AsyncValue<void>>(
      CsvDownloadNotifier.new,
    );
