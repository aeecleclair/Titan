import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class EventEventListProvider extends ListNotifier2<EventReturn> {
  final Openapi eventRepository;
  EventEventListProvider({required this.eventRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<EventReturn>>> loadConfirmedEvent(
      String userId) async {
    return await loadList(() async =>
        eventRepository.calendarEventsUserApplicantIdGet(applicantId: userId));
  }
}

final eventEventListProvider = StateNotifierProvider<EventEventListProvider,
    AsyncValue<List<EventReturn>>>((ref) {
  final eventRepository = ref.watch(repositoryProvider);
  final userId = ref.watch(idProvider);
  final provider = EventEventListProvider(eventRepository: eventRepository);
  tokenExpireWrapperAuth(ref, () async {
    userId.whenData((value) async {
      await provider.loadConfirmedEvent(value);
    });
  });
  return provider;
});
