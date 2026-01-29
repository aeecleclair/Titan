import 'package:titan/ticketing/class/session.dart';
import 'package:titan/tools/repository/repository.dart';

class SessionRepository extends Repository {
  @override
  // ignore: override_on_non_overriding_member
  Future<List<Session>> getAllSession(String categoryId) async {
    // return (await getList(
    //   suffix: 'events',
    // )).map((e) => Event.fromJson(e)).toList();
    // Liste de test au lieu d'appeler l'API
    return [
      // Event 1 : Soirée Pizza BDE
      Session(
        id: '1',
        eventId: '1',
        name: 'Soirée Pizza - 19h00',
        quota: 100,
        usedQuota: 67,
        userQuota: 1,
        disabled: false,
      ),

      // Event 2 : Tournoi de Foot
      Session(
        id: '2',
        eventId: '2',
        name: 'Tournoi - Phase de groupe',
        quota: 12,
        usedQuota: 10,
        userQuota: 1,
        disabled: false,
      ),
      Session(
        id: '3',
        eventId: '2',
        name: 'Tournoi - Demi-finales',
        quota: 4,
        usedQuota: 0,
        userQuota: 0,
        disabled: false,
      ),
      Session(
        id: '4',
        eventId: '2',
        name: 'Tournoi - Finale',
        quota: 2,
        usedQuota: 0,
        userQuota: 0,
        disabled: false,
      ),

      // Event 3 : Conférence Tech
      Session(
        id: '5',
        eventId: '3',
        name: 'Workshop - Session matin',
        quota: 30,
        usedQuota: 28,
        userQuota: 0,
        disabled: false,
      ),
      Session(
        id: '6',
        eventId: '3',
        name: 'Conférence principale - 14h00',
        quota: 200,
        usedQuota: 145,
        userQuota: 2,
        disabled: false,
      ),

      // Event 4 : Gala de fin d'année
      Session(
        id: '7',
        eventId: '4',
        name: 'Dîner - 19h30',
        quota: 150,
        usedQuota: 120,
        userQuota: 2,
        disabled: false,
      ),
      Session(
        id: '8',
        eventId: '4',
        name: 'Spectacle - 21h00',
        quota: 180,
        usedQuota: 120,
        userQuota: 2,
        disabled: false,
      ),
      Session(
        id: '9',
        eventId: '4',
        name: 'Soirée dansante - 22h30',
        quota: 200,
        usedQuota: 120,
        userQuota: 2,
        disabled: false,
      ),

      // Event 5 : Week-end Ski
      Session(
        id: '10',
        eventId: '5',
        name: 'Cours débutant - Samedi matin',
        quota: 15,
        usedQuota: 12,
        userQuota: 1,
        disabled: false,
      ),
      Session(
        id: '11',
        eventId: '5',
        name: 'Ski libre - Samedi',
        quota: 60,
        usedQuota: 48,
        userQuota: 2,
        disabled: false,
      ),
      Session(
        id: '12',
        eventId: '5',
        name: 'Ski libre - Dimanche',
        quota: 60,
        usedQuota: 42,
        userQuota: 2,
        disabled: false,
      ),
      Session(
        id: '13',
        eventId: '5',
        name: 'Ski de nuit - Samedi soir',
        quota: 30,
        usedQuota: 30,
        userQuota: 1,
        disabled: true, // Complet
      ),
    ];
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
