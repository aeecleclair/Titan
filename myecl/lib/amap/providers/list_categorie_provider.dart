import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/list_produit_provider.dart';

/// Le notifier de la liste des catégories, permet de modifier la liste des commandes
class ListeCategorieNotifier extends StateNotifier<List<String>> {
  ListeCategorieNotifier([List<String>? cmds]) : super(cmds ?? []);

  /// **Ajoute une catégorie à la liste des catégories**
  ///
  /// Paramètre :
  /// * c (String) la catégorie à ajouter
  void ajouterCategorie(String c) {
    state = [...state, c]..sort();
  }

  /// **Supprime la catégorie à la liste des catégories**
  ///
  /// Paramètre :
  /// * c (String) la catégorie à supprimer
  void removeCategorie(String c) {
    state = state.sublist(0)..remove(c);
  }
}

/// Le provider de la liste des commandes, permet d'avoir accès à la liste des commandes partout dans l'application
final listeCategorieProvider =
    StateNotifierProvider<ListeCategorieNotifier, List<String>>((ref) {
  final produits = ref.watch(listeProduitprovider);
  // Par défaut la liste est vide, elle est remplie par la réponse du serveur
  return ListeCategorieNotifier([
    ...{...produits.map((e) => e.categorie)}
  ]..sort());
});
