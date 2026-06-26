import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class EventNotifier extends SingleNotifierAPI<EventCompleteTicketUrl> {
  Openapi get eventRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<EventCompleteTicketUrl> build() {
    fakeLoad();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<EventCompleteTicketUrl>> addEvent(
    EventBaseCreation event,
  ) async {
    return await load(() => eventRepository.calendarEventsPost(body: event));
  }

  void fakeLoad() {
    state = AsyncValue.data(EventCompleteTicketUrl.empty());
  }

  void setEvent(EventCompleteTicketUrl event) {
    state = AsyncValue.data(event);
  }
}

final eventProvider =
    NotifierProvider<EventNotifier, AsyncValue<EventCompleteTicketUrl>>(
      EventNotifier.new,
    );
