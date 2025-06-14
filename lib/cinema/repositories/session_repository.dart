import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/cinema/class/session.dart';
import 'package:titan/tools/repository/repository.dart';

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
    return Session.fromJson(await create(session.toJson()));
  }

  Future<bool> updateSession(Session session) async {
    return await update(session.toJson(), "/${session.id}");
  }

  Future<bool> deleteSession(String id) async {
    return await delete("/$id");
  }
}

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return SessionRepository()..setToken(token);
});
