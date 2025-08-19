import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/feed/class/event_creation.dart';
import 'package:titan/feed/class/ticket_url.dart';
import 'package:titan/tools/repository/repository.dart';

class EventCreationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "calendar/events/";

  Future<EventCreation> createEvent(EventCreation event) async {
    return EventCreation.fromJson(await create(event.toJson()));
  }

  Future<TicketUrl> getTicketUrl(String id) async {
    return TicketUrl.fromJson(await getOne(id, suffix: "/ticket-url"));
  }
}

final eventCreationRepositoryProvider = Provider<EventCreationRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return EventCreationRepository()..setToken(token);
});
