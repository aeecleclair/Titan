import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/event/class/event.dart';
import 'package:titan/event/repositories/event_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class ConfirmedEventListProvider extends ListNotifier<Event> {
  final EventRepository eventRepository;
  ConfirmedEventListProvider({required this.eventRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Event>>> loadConfirmedEvent() async {
    return await loadList(eventRepository.getConfirmedEventList);
  }

  Future<bool> addEvent(Event booking) async {
    return await add((b) async => b, booking);
  }

  Future<bool> deleteEvent(Event booking) async {
    return await delete(
      (_) async => true,
      (bookings, booking) =>
          bookings..removeWhere((element) => element.id == booking.id),
      booking.id,
      booking,
    );
  }
}

final confirmedEventListProvider =
    StateNotifierProvider<ConfirmedEventListProvider, AsyncValue<List<Event>>>((
      ref,
    ) {
      final eventRepository = ref.watch(eventRepositoryProvider);
      final provider = ConfirmedEventListProvider(
        eventRepository: eventRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadConfirmedEvent();
      });
      return provider;
    });
