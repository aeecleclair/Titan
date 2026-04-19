import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/repositories/tickets_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class ShotgunListNotifier extends ListNotifier<TicketEvent> {
  final TicketsRepository _ticketsRepository = TicketsRepository();
  ShotgunListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    _ticketsRepository.setToken(token);
  }

  Future<AsyncValue<List<TicketEvent>>> loadShotgunList() async {
    return await loadList(() async => _ticketsRepository.getAllShotgun());
  }

  Future<TicketEvent> loadShotgunById(String id) async {
    return await _ticketsRepository.getTicketEventById(id);
  }

  Future<bool> createTicketEvent(TicketEvent ticketEvent) async {
    return await add(_ticketsRepository.createTicketEvent, ticketEvent);
  }

  Future<bool> editTicketEvent(TicketEvent ticketEvent) async {
    return await delete(
      _ticketsRepository.deleteTicketEvent,
      (ticketEvents, ticketEvent) =>
          ticketEvents..removeWhere((toCheck) => toCheck.id == ticketEvent.id),
      ticketEvent.id,
      ticketEvent,
    );
  }
}

final ticketEventListProvider =
    StateNotifierProvider<ShotgunListNotifier, AsyncValue<List<TicketEvent>>>((
      ref,
    ) {
      final token = ref.watch(tokenProvider);
      final notifier = ShotgunListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadShotgunList();
      });
      return notifier;
    });
