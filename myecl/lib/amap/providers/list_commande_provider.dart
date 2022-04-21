import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/commande.dart';
import 'package:myecl/amap/class/produit.dart';
import 'package:uuid/uuid.dart';

/// Permet de crée des identifiants unique pour chaque produit et commande
var _uuid = const Uuid();

/// Le notifier de la liste des commande, permet de modifier la liste des commandes
class ListeCommandeNotifier extends StateNotifier<List<Commande>> {
  ListeCommandeNotifier([List<Commande>? listCmd]) : super(listCmd ?? []);

  /// **Ajoute un produit à la commande dont on donne l'index dans la liste des commandes**
  ///
  /// Paramètres :
  /// * i (int) l'index de la commande dans la liste des commandes
  /// * p (Produit) le produit à ajouter
  void addProduit(int i, Produit p) {
    // On copie pour éviter les alias (si on fait une nouvelle commande, on pourrait changer la quantité pour cette commande)
    state[i].produits.add(p.copy());
  }

  /// **Supprime un produit à la commande dont on donne l'index dans la liste des commandes**
  ///
  /// Paramètres :
  /// * i (int) l'index de la commande dans la liste des commandes
  /// * p (Produit) le produit à ajouter
  void removeProduits(int i, Produit p) {
    state[i].produits.removeWhere((element) => element.nom == p.nom);
  }

  /// **Supprime la commande dont on donne l'index dans la liste des commandes**
  ///
  /// Paramètre :
  /// * i (int) l'index de la commande dans la liste des commandes
  void removeCommande(int i) {
    /** Le .. permet d'appliquer une fonction void et de retourner l'objet modifié
     *
     * Code équivalent :
     *
     * ```dart
       List<Commande> r = state.sublist(0);
       r.removeAt(i);
       state = r;
     * ```
     */
    state = state.sublist(0)..removeAt(i);
  }

  /// **Ajoute une commande à la lsite des commandes**
  ///
  /// Paramètres :
  /// * i (int) l'index de la commande dans la liste des commandes
  /// * p (Produit) le produit à ajouter
  void addCommande(DateTime date, List<Produit> produits) {
    state = [
      // On récupère tous les objets contenus dans state (ici de type List<Commande>) (Voir addProduit pour le code équivalent)
      ...state,
      // On ajoute la nouvelle commande
      Commande(
        id: _uuid.v4(),
        date: date,
        produits: produits,
      ),
    ];
  }

  /// **Change la quantité d'un produit d'une commande**
  ///
  /// Paramètres :
  /// * i (int) l'index de la commande dans la liste des commandes
  /// * p (Produit) le produit à ajouter
  /// * quantite (int) la nouvelle quantité
  void setProduitQuantite(int i, Produit p, int quantite) {
    // On copie la liste des commandes
    List<Commande> r = state.sublist(0);
    // on trouve le produit dans la commande et on change sa quantité
    for (int j = 0; j < r[i].produits.length; j++) {
      if (r[i].produits[j].id == p.id) {
        r[i].produits[j].quantite = quantite;
      }
    }
    // On met à jour l'état
    state = r;
  }

  /// **Change la valeur de expanded de la commande dont on donne l'identifiant**
  ///
  /// Paramètre :
  /// * id (String) l'identifiant de la commande à inverser
  void toggleExpanded(String id) {
    state = [
      for (final p in state)
        if (p.id == id)
          Commande(
              id: p.id,
              date: p.date,
              produits: p.produits,
              expanded: !p.expanded)
        else
          p,
    ];
  }

  /// **Met à jour la liste des produits de la commande**
  ///
  /// Paramètres :
  /// * id (String) l'identifiant de la commande à inverser
  /// * produits (List<Produit>) la liste de produit à ajouter
  void setProduits(String id, List<Produit> produits) {
    state = [
      for (final p in state)
        if (p.id == id)
          Commande(
              id: p.id, date: p.date, produits: produits, expanded: p.expanded)
        else
          p,
    ];
  }

  /// **Renvoie le prix de la commande**
  ///
  /// Paramètres :
  /// * i (int) l'index de la commande dans la liste des commandes
  ///
  /// Résultat :
  /// * (double) le prix de la commande
  double getPrix(int i) {
    return state[i]
        .produits
        // On extrait le prix de chaque produit multiplié par leur quantité dans la commande
        .map((e) => e.prix * e.quantite)
        // On réduit la liste en sommant tout les termes
        .reduce((value, element) => value + element);
  }
}

/// Le provider de la liste des commandes, permet d'avoir accès à la liste des commandes partout dans l'application
final listCommandeProvider =
    StateNotifierProvider<ListeCommandeNotifier, List<Commande>>((ref) {
  // Par défaut la liste est vide, elle est remplie par la réponse du serveur
  return ListeCommandeNotifier([]);
});
