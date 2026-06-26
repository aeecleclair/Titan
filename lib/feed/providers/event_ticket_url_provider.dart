import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class TicketUrlNotifier extends SingleNotifierAPI<EventTicketUrl> {
  Openapi get eventRepository => ref.watch(repositoryProvider);
  @override
  AsyncValue<EventTicketUrl> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<EventTicketUrl>> getTicketUrl(String eventId) async {
    return await load(
      () => eventRepository.calendarEventsEventIdTicketUrlGet(eventId: eventId),
    );
  }
}

final ticketUrlProvider =
    NotifierProvider<TicketUrlNotifier, AsyncValue<EventTicketUrl>>(
      TicketUrlNotifier.new,
    );
