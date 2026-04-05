import 'package:titan/ticketing/class/event.dart';
import 'package:titan/tools/repository/repository.dart';

class EventRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'ticketing/';

  Future<List<Event>> getAllEvent() async {
    return (await getList(
      suffix: 'events',
    )).map((e) => Event.fromJson(e)).toList();
  }

  Future<Event> getEvent(String id) async {
    print("Fetching event with id: $id");
    return Event.fromJson(await getOne(id, suffix: 'events'));
  }

  Future<Event> addEvent(Event event) async {
    return Event.fromJson(await create(event.toJson(), suffix: 'events'));
  }
}
