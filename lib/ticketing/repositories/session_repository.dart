import 'package:titan/cinema/class/session.dart';
import 'package:titan/tools/repository/repository.dart';

class SessionRepository extends Repository {
  @override
  Future<List<Session>> getAllSession(String id) async {
    // return (await getList(
    //   suffix: 'events',
    // )).map((e) => Event.fromJson(e)).toList();
    // Liste de test au lieu d'appeler l'API
    return [];
  }

  Future<Session> getSession(String id) async {
    return Session.fromJson(await getOne(id));
  }

  Future<Session> addSession(Session session) async {
    return Session.fromJson(await create(session.toJson(), suffix: 'sessions'));
  }

  Future<bool> updateSession(Session session) async {
    return await update(session.toJson(), "sessions/${session.id}");
  }

  Future<bool> deleteSession(String id) async {
    return await delete("sessions/$id");
  }
}
