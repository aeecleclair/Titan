import 'package:myecl/cinema/class/session.dart';
import 'package:myecl/cinema/services/cinema_notification.dart';
import 'package:myecl/tools/repository/repository.dart';

class SessionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'cinema/sessions';
  final CinemaNotification cinemaNotification = CinemaNotification()..init();

  Future<List<Session>> getAllSessions() async {
    final List<Session> sessionList =
        (await getList()).map((e) => Session.fromJson(e)).toList();
    cinemaNotification.scheduleAllSession(sessionList);
    return sessionList;
  }

  Future<Session> getSession(String id) async {
    return Session.fromJson(await getOne(id));
  }

  Future<Session> addSession(Session session) async {
    return Session.fromJson(await create(session.toJson()));
  }

  Future<bool> updateSession(Session session) async {
    return await update(session.toJson(), "/${session.id}");
  }

  Future<bool> deleteSession(String id) async {
    return await delete("/$id");
  }
}
