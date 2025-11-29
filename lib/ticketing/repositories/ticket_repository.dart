import 'package:titan/ticketing/class/event.dart';
import 'package:titan/ticketing/class/announcer.dart';
import 'package:titan/tools/repository/repository.dart';

class EventRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'event/';

  Future<List<Event>> getAllEvent() async {
    // return (await getList(
    //   suffix: 'events',
    // )).map((e) => Event.fromJson(e)).toList();
    // Liste de test au lieu d'appeler l'API
    return [
      Event(
        id: "1",
        title: "Soirée Pizza BDE",
        content:
            "Venez nombreux pour une soirée pizza organisée par le BDE ! Inscriptions ouvertes dès maintenant.",
        date: DateTime.now().add(Duration(days: 7)),
        announcer: Announcer(
          id: "bde_001",
          name: "Bureau Des Étudiants",
          groupManagerId: "manager_bde",
        ),
        ticket: "Gratuit",
        form: ["Nom", "Prénom", "Email", "Allergies alimentaires"],
      ),
      Event(
        id: "2",
        title: "Tournoi de Foot Inter-Écoles",
        content:
            "Grand tournoi de football entre les différentes écoles de la région. Équipes de 11 joueurs.",
        date: DateTime.now().add(Duration(days: 14)),
        announcer: Announcer(
          id: "sport_001",
          name: "Association Sportive",
          groupManagerId: "manager_sport",
        ),
        ticket: "5€ par équipe",
        form: ["Nom équipe", "Capitaine", "Liste joueurs", "Contact"],
      ),
      Event(
        id: "3",
        title: "Conférence Tech",
        content:
            "Conférence sur les nouvelles technologies avec des intervenants de grandes entreprises tech.",
        date: DateTime.now().add(Duration(days: 21)),
        announcer: Announcer(
          id: "tech_001",
          name: "Club Informatique",
          groupManagerId: "manager_tech",
        ),
        ticket: "Gratuit pour les étudiants",
        form: ["Nom", "Prénom", "Niveau d'étude", "Spécialité"],
      ),
      Event(
        id: "4",
        title: "Gala de fin d'année",
        content:
            "Le grand gala de fin d'année avec dîner, spectacle et soirée dansante. Tenue de soirée exigée.",
        date: DateTime.now().add(Duration(days: 90)),
        announcer: Announcer(
          id: "gala_001",
          name: "Comité des Fêtes",
          groupManagerId: "manager_fetes",
        ),
        ticket: "45€",
        form: [
          "Nom",
          "Prénom",
          "Email",
          "Téléphone",
          "Régime alimentaire",
          "Accompagnant",
        ],
      ),
      Event(
        id: "5",
        title: "Week-end Ski",
        content:
            "Week-end au ski dans les Alpes ! Transport en bus, hébergement et forfaits inclus.",
        date: DateTime.now().add(Duration(days: 45)),
        announcer: Announcer(
          id: "voyage_001",
          name: "Club Voyages",
          groupManagerId: "manager_voyage",
        ),
        ticket: "180€",
        form: [
          "Nom",
          "Prénom",
          "Niveau ski",
          "Taille",
          "Pointure",
          "Contact urgence",
        ],
      ),
    ];
  }

  Future<Event> getEvent(String id) async {
    return Event.fromJson(await getOne(id));
  }

  Future<Event> addEvent(Event event) async {
    return Event.fromJson(await create(event.toJson(), suffix: 'events'));
  }

  Future<bool> updateEvent(Event event) async {
    return await update(event.toJson(), "events/${event.id}");
  }

  Future<bool> deleteEvent(String id) async {
    return await delete("events/$id");
  }
}
