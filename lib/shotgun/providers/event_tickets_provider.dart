import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/shotgun/class/ticket.dart';
import 'package:titan/shotgun/repositories/shotgun_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class EventTicketsNotifier extends ListNotifier<Ticket> {
  final ShotgunRepository shotgunRepository;
  EventTicketsNotifier({required this.shotgunRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Ticket>>> loadEventTickets(String eventId) async {
    return await loadList(
      () => shotgunRepository.getTicketsByEventId(eventId),
    );
  }
}

final eventTicketsProvider =
    StateNotifierProvider<EventTicketsNotifier, AsyncValue<List<Ticket>>>(
      (ref) {
        final token = ref.watch(tokenProvider);
        final shotgunRepository = ShotgunRepository()..setToken(token);
        return EventTicketsNotifier(shotgunRepository: shotgunRepository);
      },
    );
