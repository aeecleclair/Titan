import 'package:titan/ticketing/class/category.dart';
import 'package:titan/tools/repository/repository.dart';

class CategoryRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'categories/';

  Future<List<Category>> getAllCategory(String eventId) async {
    // return (await getList(
    //   suffix: 'events',
    // )).map((e) => Event.fromJson(e)).toList();
    // Liste de test au lieu d'appeler l'API
    return [
      // Soirée Pizza BDE
      Category(
        id: '1',
        eventId: '1',
        name: 'Place Standard',
        linkedSessions: ['1'], // Soirée Pizza - 19h00
        requiredMembership: '',
        price: 0.00,
        disabled: false,
      ),
      Category(
        id: '2',
        eventId: '1',
        name: 'Menu Végétarien',
        linkedSessions: ['1'], // Soirée Pizza - 19h00
        requiredMembership: '',
        price: 0.00,
        disabled: false,
      ),

      // Tournoi de Foot
      Category(
        id: '3',
        eventId: '2',
        name: 'Équipe Complète (11 joueurs)',
        linkedSessions: ['2'], // Tournoi - Phase de groupe
        requiredMembership: '',
        price: 5.00,
        disabled: false,
      ),
      Category(
        id: '4',
        eventId: '2',
        name: 'Spectateur',
        linkedSessions: ['2', '3', '4'], // Toutes les phases du tournoi
        requiredMembership: '',
        price: 0.00,
        disabled: false,
      ),

      // Conférence Tech
      Category(
        id: '5',
        eventId: '3',
        name: 'Étudiant',
        linkedSessions: ['6'], // Conférence principale - 14h00
        requiredMembership: 'student',
        price: 0.00,
        disabled: false,
      ),
      Category(
        id: '6',
        eventId: '3',
        name: 'Professionnel',
        linkedSessions: ['6'], // Conférence principale - 14h00
        requiredMembership: '',
        price: 25.00,
        disabled: false,
      ),
      Category(
        id: '7',
        eventId: '3',
        name: 'Workshop + Conférence',
        linkedSessions: ['5', '6'], // Workshop matin + Conférence
        requiredMembership: '',
        price: 45.00,
        disabled: false,
      ),

      // Gala de fin d'année
      Category(
        id: '8',
        eventId: '4',
        name: 'Solo',
        linkedSessions: ['7', '8', '9'], // Dîner + Spectacle + Soirée dansante
        requiredMembership: '',
        price: 45.00,
        disabled: false,
      ),
      Category(
        id: '9',
        eventId: '4',
        name: 'Duo',
        linkedSessions: ['7', '8', '9'], // Dîner + Spectacle + Soirée dansante
        requiredMembership: '',
        price: 80.00,
        disabled: false,
      ),
      Category(
        id: '10',
        eventId: '4',
        name: 'Table VIP (10 personnes)',
        linkedSessions: ['7', '8', '9'], // Dîner + Spectacle + Soirée dansante
        requiredMembership: 'premium',
        price: 400.00,
        disabled: false,
      ),
      Category(
        id: '11',
        eventId: '4',
        name: 'Table VIP (10 personnes) - Complet',
        linkedSessions: ['7', '8', '9'], // Dîner + Spectacle + Soirée dansante
        requiredMembership: 'premium',
        price: 400.00,
        disabled: true,
      ),

      // Week-end Ski
      Category(
        id: '12',
        eventId: '5',
        name: 'Pack Complet (Transport + Hébergement + Forfait)',
        linkedSessions: ['11', '12'], // Ski libre Samedi + Dimanche
        requiredMembership: '',
        price: 180.00,
        disabled: false,
      ),
      Category(
        id: '13',
        eventId: '5',
        name: 'Sans matériel',
        linkedSessions: ['11', '12'], // Ski libre Samedi + Dimanche
        requiredMembership: '',
        price: 165.00,
        disabled: false,
      ),
      Category(
        id: '14',
        eventId: '5',
        name: 'Débutant avec cours',
        linkedSessions: [
          '10',
          '11',
          '12',
        ], // Cours + Ski libre Samedi + Dimanche
        requiredMembership: '',
        price: 220.00,
        disabled: false,
      ),
      Category(
        id: '15',
        eventId: '5',
        name: 'Samedi uniquement',
        linkedSessions: ['11'], // Ski libre - Samedi
        requiredMembership: '',
        price: 95.00,
        disabled: false,
      ),
    ];
  }
}
