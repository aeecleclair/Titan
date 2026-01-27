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
        linkedSessions: ['soiree'],
        requiredMembership: '',
        price: 0.00,
        disabled: false,
      ),
      Category(
        id: '2',
        eventId: '1',
        name: 'Menu Végétarien',
        linkedSessions: ['soiree'],
        requiredMembership: '',
        price: 0.00,
        disabled: false,
      ),

      // Tournoi de Foot
      Category(
        id: '3',
        eventId: '2',
        name: 'Équipe Complète (11 joueurs)',
        linkedSessions: ['tournoi'],
        requiredMembership: '',
        price: 5.00,
        disabled: false,
      ),
      Category(
        id: '4',
        eventId: '2',
        name: 'Spectateur',
        linkedSessions: ['tournoi'],
        requiredMembership: '',
        price: 0.00,
        disabled: false,
      ),

      // Conférence Tech
      Category(
        id: '5',
        eventId: '3',
        name: 'Étudiant',
        linkedSessions: ['conference'],
        requiredMembership: 'student',
        price: 0.00,
        disabled: false,
      ),
      Category(
        id: '6',
        eventId: '3',
        name: 'Professionnel',
        linkedSessions: ['conference'],
        requiredMembership: '',
        price: 25.00,
        disabled: false,
      ),
      Category(
        id: '7',
        eventId: '3',
        name: 'Workshop + Conférence',
        linkedSessions: ['workshop', 'conference'],
        requiredMembership: '',
        price: 45.00,
        disabled: false,
      ),

      // Gala de fin d'année
      Category(
        id: '8',
        eventId: '4',
        name: 'Solo',
        linkedSessions: ['diner', 'spectacle', 'soiree'],
        requiredMembership: '',
        price: 45.00,
        disabled: false,
      ),
      Category(
        id: '9',
        eventId: '4',
        name: 'Duo',
        linkedSessions: ['diner', 'spectacle', 'soiree'],
        requiredMembership: '',
        price: 80.00,
        disabled: false,
      ),
      Category(
        id: '10',
        eventId: '4',
        name: 'Table VIP (10 personnes)',
        linkedSessions: ['diner', 'spectacle', 'soiree'],
        requiredMembership: 'premium',
        price: 400.00,
        disabled: false,
      ),
      Category(
        id: '11',
        eventId: '4',
        name: 'Table VIP (10 personnes) - Complet',
        linkedSessions: ['diner', 'spectacle', 'soiree'],
        requiredMembership: 'premium',
        price: 400.00,
        disabled: true,
      ),

      // Week-end Ski
      Category(
        id: '12',
        eventId: '5',
        name: 'Pack Complet (Transport + Hébergement + Forfait)',
        linkedSessions: ['samedi', 'dimanche'],
        requiredMembership: '',
        price: 180.00,
        disabled: false,
      ),
      Category(
        id: '13',
        eventId: '5',
        name: 'Sans matériel',
        linkedSessions: ['samedi', 'dimanche'],
        requiredMembership: '',
        price: 165.00,
        disabled: false,
      ),
      Category(
        id: '14',
        eventId: '5',
        name: 'Débutant avec cours',
        linkedSessions: ['cours_debutant', 'samedi', 'dimanche'],
        requiredMembership: '',
        price: 220.00,
        disabled: false,
      ),
      Category(
        id: '15',
        eventId: '5',
        name: 'Samedi uniquement',
        linkedSessions: ['samedi'],
        requiredMembership: '',
        price: 95.00,
        disabled: false,
      ),
    ];
  }
}
