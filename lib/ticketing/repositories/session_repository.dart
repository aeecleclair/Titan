import 'package:titan/ticketing/class/event.dart';
import 'package:titan/ticketing/class/session.dart';
import 'package:titan/tools/repository/repository.dart';

class SessionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'ticketing/';

  Future<List<Session>> getAllSession(String eventID) async {
    return Event.fromJson(await getOne('events/$eventID')).sessions;
  }

  Future<Session> getSession(String id) async {
    return Session.fromJson(await getOne(id, suffix: 'sessions'));
  }
}
