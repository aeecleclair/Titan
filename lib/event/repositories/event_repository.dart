import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/tools/repository/repository.dart';

class EventRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "calendar/events/";

  EventRepository(super.ref);

  Future<List<Event>> getAllEvent() async {
    return List<Event>.from((await getList()).map((x) => Event.fromJson(x)));
  }

  Future<List<Event>> getConfirmedEventList() async {
    return List<Event>.from(
      (await getList(suffix: "confirmed")).map((x) => Event.fromJson(x)),
    );
  }

  Future<List<Event>> getUserEventList(String id) async {
    return List<Event>.from(
      (await getList(suffix: "user/$id")).map((x) => Event.fromJson(x)),
    );
  }

  Future<bool> confirmEvent(Event event) async {
    return await update(
      {},
      event.id,
      suffix: '/reply/${event.decision.toString().split('.')[1]}',
    );
  }

  Future<Event> getEvent(String id) async {
    return Event.fromJson(await getOne(id));
  }

  Future<Event> createEvent(Event event) async {
    return Event.fromJson(await create(event.toJson()));
  }

  Future<bool> updateEvent(Event event) async {
    return await update(event.toJson(), event.id);
  }

  Future<bool> deleteEvent(String id) async {
    return await delete(id);
  }
}
