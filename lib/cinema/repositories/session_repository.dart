import 'package:myecl/cinema/class/session/session.dart';
import 'package:myecl/cinema/class/session/session_return.dart';
import 'package:myecl/tools/repository/repository.dart';

class SessionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'cinema/sessions';

  Future<List<Session>> getAllSessions() async {
    return (await getList()).map((e) => Session.fromJson(e)).toList();
  }

  Future<Session> getSession(String id) async {
    return Session.fromJson(await getOne(id));
  }

  Future<Session> addSession(Session session) async {
    final SessionReturn sessionReturn = SessionReturn.fromSession(session);
    return Session.fromJson(await create(sessionReturn.toJson()));
  }

  Future<bool> updateSession(Session session) async {
    final SessionReturn sessionReturn = SessionReturn.fromSession(session);
    return await update(sessionReturn.toJson(), "/${session.id}");
  }

  Future<bool> deleteSession(String id) async {
    return await delete("/$id");
  }
}
