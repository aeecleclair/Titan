import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/feed/class/ticket_url.dart';
import 'package:titan/feed/repositories/event_creation_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class TicketUrlNotifier extends SingleNotifier<TicketUrl> {
  final EventCreationRepository eventRepository;
  TicketUrlNotifier({required this.eventRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<TicketUrl>> getTicketUrl(String eventId) async {
    return await load(() => eventRepository.getTicketUrl(eventId));
  }
}

final ticketUrlProvider =
    StateNotifierProvider<TicketUrlNotifier, AsyncValue<TicketUrl>>((ref) {
      final eventRepository = ref.watch(eventCreationRepositoryProvider);
      TicketUrlNotifier notifier = TicketUrlNotifier(
        eventRepository: eventRepository,
      );
      return notifier;
    });
