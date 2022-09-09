import 'package:myecl/event/class/event.dart';
import 'package:myecl/tools/repository/repository.dart';

class EventRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "calendar/events/";

  Future<List<Event>> getAllEvent() async {
    return List<Event>.from((await getList()).map((x) => Event.fromJson(x)));
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
