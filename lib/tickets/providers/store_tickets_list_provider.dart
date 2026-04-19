import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/repositories/ticket_event_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class StoreTicketEventListNotifier extends ListNotifier<TicketEvent> {
  final TicketEventRepository ticketEventRepository;
  StoreTicketEventListNotifier({required this.ticketEventRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<TicketEvent>>> loadStoreTicketEventList(
    String storeId,
  ) async {
    return await loadList(
      () => ticketEventRepository.getTicketEventListByStoreId(storeId),
    );
  }
}

final storeTicketEventListProvider =
    StateNotifierProvider<
      StoreTicketEventListNotifier,
      AsyncValue<List<TicketEvent>>
    >((ref) {
      final token = ref.watch(tokenProvider);
      final ticketEventRepository = TicketEventRepository()..setToken(token);
      return StoreTicketEventListNotifier(
        ticketEventRepository: ticketEventRepository,
      );
    });
