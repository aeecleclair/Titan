import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/feed/class/event.dart';
import 'package:titan/feed/class/ticket_url.dart';
import 'package:titan/tools/repository/repository.dart';

class EventRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "calendar/events/";

  Future<Event> createEvent(Event event) async {
    return Event.fromJson(await create(event.toJson()));
  }

  Future<List<Event>> getEventList() async {
    return List<Event>.from((await getList()).map((e) => Event.fromJson(e)));
  }

  Future<List<Event>> getAssociationEventList(String id) async {
    return List<Event>.from(
      (await getList(suffix: "associations/$id")).map((e) => Event.fromJson(e)),
    );
  }

  Future<TicketUrl> getTicketUrl(String id) async {
    return TicketUrl.fromJson(await getOne(id, suffix: "/ticket-url"));
  }

  Future<bool> updateEvent(Event event) async {
    return await update(event.toJson(), event.id);
  }

  Future<bool> deleteEvent(String id) async {
    return await delete(id);
  }
}

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return EventRepository()..setToken(token);
});
