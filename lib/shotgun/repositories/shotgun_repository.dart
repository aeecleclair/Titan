import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/class/announcer.dart';
import 'package:titan/tools/repository/repository.dart';

class ShotgunRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'shotgun/';

  Future<List<Shotgun>> getAllShotgun() async {
    // return (await getList(
    //   suffix: 'shotguns',
    // )).map((e) => Shotgun.fromJson(e)).toList();
    // Liste de test au lieu d'appeler l'API
    return [
      Shotgun(
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
      Shotgun(
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
      Shotgun(
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
      Shotgun(
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
      Shotgun(
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

  Future<Shotgun> getShotgun(String id) async {
    return Shotgun.fromJson(await getOne(id));
  }

  Future<Shotgun> addShotgun(Shotgun shotgun) async {
    return Shotgun.fromJson(await create(shotgun.toJson(), suffix: 'shotguns'));
  }

  Future<bool> updateShotgun(Shotgun shotgun) async {
    return await update(shotgun.toJson(), "shotguns/${shotgun.id}");
  }

  Future<bool> deleteShotgun(String id) async {
    return await delete("shotguns/$id");
  }
}
