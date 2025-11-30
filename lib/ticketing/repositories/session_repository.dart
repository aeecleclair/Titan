import 'package:titan/cinema/class/session.dart';
import 'package:titan/tools/repository/repository.dart';

class SessionRepository extends Repository {
  @override
  Future<List<Session>> getAllSession() async {
    // return (await getList(
    //   suffix: 'events',
    // )).map((e) => Event.fromJson(e)).toList();
    // Liste de test au lieu d'appeler l'API
    return [];
  }

  Future<Session> getSession(String id) async {
    return Session.fromJson(await getOne(id));
  }

  Future<Session> addSession(Session Session) async {
    return Session.fromJson(await create(Session.toJson(), suffix: 'Sessions'));
  }

  Future<bool> updateSession(Session Session) async {
    return await update(Session.toJson(), "Sessions/${Session.id}");
  }

  Future<bool> deleteSession(String id) async {
    return await delete("Sessions/$id");
  }
}
