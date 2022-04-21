import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/produit.dart';
import 'package:uuid/uuid.dart';

/// Permet de crée des identifiants unique pour chaque produit et commande
var _uuid = const Uuid();


/// Le notifier de la liste des produits, permet de modifier la liste des produits
class ListProduitNotifier extends StateNotifier<List<Produit>> {
  ListProduitNotifier([List<Produit>? listProduits])
      : super(listProduits ?? []);

  /// **Change la quantité du produit dont l'identifiant est donné**
  ///
  /// Paramètres :
  /// * id (String) l'identifiant du produit
  /// * i (int) la nouvelle quantité
  void setQuantity(String id, int i) {
    // C'est une compréhension de liste (il n'y a pas d'accolades)
    state = [
      // Pour chaque produit
      for (final p in state)
        // Si c'est le produit que l'on cherche
        if (p.id == id)
          // On retourne un nouveau produit dont on a modifié la quantité
          Produit(
              id: p.id,
              nom: p.nom,
              prix: p.prix,
              quantite: i,
              categorie: p.categorie)
        // Sinon on retourne le produit
        else
          p,
    ];
  }

  /// **Ajoute un produit à la liste**
  ///
  /// Paramètres :
  /// * nom (String) le nom du produit
  /// * prix (double) le prix du produit
  /// * categorie (String) la catégorie du produit
  void addProduit(String nom, double prix, String categorie) {
    state = [
      /** On récupère tous les objets contenus dans state (ici de type List<Produit>)
       *
       * Code équivalent :
       *
       * ```dart
        List<Produit> r = state.sublist(0);
        r.append(Produit(...));
        state = r;
       * ```
       */
      ...state,
      // On ajoute un produit
      Produit(
          // On génère un identifiant aléatoirement
          id: _uuid.v4(),
          nom: nom,
          prix: prix,
          // Ce produit n'as pas encore été commandé
          quantite: 0,
          categorie: categorie),
    ];
  }

  /// **Met à jour le produit dont on donne l'identifiant et les nouvelles informations**
  ///
  /// Paramètres :
  /// * id (String) l'identifiant
  /// * nom (String) le nom du produit
  /// * prix (double) le prix du produit
  /// * categorie (String) la catégorie du produit
  void updateProduit(String id, String nom, double prix, String categorie) {
    // C'est une compréhension de liste (il n'y a pas d'accolade)
    state = [
      // Pour chaque produit
      for (final p in state)
        // Si c'est le produit que l'on cherche
        if (p.id == id)
          // On retourne un nouveau produit dont on a modifié les paramètres
          Produit(
              id: p.id,
              nom: nom,
              prix: prix,
              quantite: p.quantite,
              categorie: categorie)
        // Sinon on retourne le produit
        else
          p,
    ];
  }

  /// **Supprime le produit dont on donne l'identifiant de la liste des produits**
  ///
  /// Paramètre :
  /// * id (String) l'identifiant
  void deleteProduit(String id) {
    // On enlève le produit qui a le même identifiant que l'identifiant
    state = state.where((p) => p.id != id).toList();
  }
}

/// Le provider de la liste des produits, permet d'avoir accès à la liste des produits partout dans l'application
final listeProduitprovider =
    StateNotifierProvider<ListProduitNotifier, List<Produit>>((ref) {
  // TODO Le liste doit être vide puis initialisée avec la réponse du serveur
  return ListProduitNotifier([
    Produit(
        id: _uuid.v4(),
        nom: "Panier de fruits et légumes pour 2",
        prix: 10.20,
        quantite: 0,
        categorie: "Les paniers"),
    Produit(
        id: _uuid.v4(),
        nom: "Panier de fruits et légume pour 4",
        prix: 16.20,
        quantite: 0,
        categorie: "Les paniers"),
    Produit(
        id: _uuid.v4(),
        nom: "Panier de fruits",
        prix: 10.20,
        quantite: 0,
        categorie: "Les paniers"),
    Produit(
        id: _uuid.v4(),
        nom: "6 oeufs",
        prix: 1.80,
        quantite: 0,
        categorie: "Les oeufs"),
    Produit(
        id: _uuid.v4(),
        nom: "12 oeufs",
        prix: 3.30,
        quantite: 0,
        categorie: "Les oeufs"),
    Produit(
        id: _uuid.v4(),
        nom: "Velouté de courgette",
        prix: 3.20,
        quantite: 0,
        categorie: "Soupes et veloutés"),
    Produit(
        id: _uuid.v4(),
        nom: "Velouté de Butternut au curry",
        prix: 3.20,
        quantite: 0,
        categorie: "Soupes et veloutés"),
    Produit(
        id: _uuid.v4(),
        nom: "Soupe de Courge",
        prix: 3.20,
        quantite: 0,
        categorie: "Soupes et veloutés"),
    Produit(
        id: _uuid.v4(),
        nom: "Soupe de Potimarron",
        prix: 3.20,
        quantite: 0,
        categorie: "Soupes et veloutés"),
    Produit(
        id: _uuid.v4(),
        nom: "Soupe de Carotte Tomate",
        prix: 3.20,
        quantite: 0,
        categorie: "Soupes et veloutés"),
    Produit(
        id: _uuid.v4(),
        nom: "Soupe de Brocoli Courgette",
        prix: 3.20,
        quantite: 0,
        categorie: "Soupes et veloutés"),
    Produit(
        id: _uuid.v4(),
        nom: "Soupe à l'oignon",
        prix: 3.20,
        quantite: 0,
        categorie: "Soupes et veloutés"),
    Produit(
        id: _uuid.v4(),
        nom: "Soupe de Carotte au Cumin",
        prix: 3.20,
        quantite: 0,
        categorie: "Soupes et veloutés"),
    Produit(
        id: _uuid.v4(),
        nom: "Soupe de légumes",
        prix: 3.20,
        quantite: 0,
        categorie: "Soupes et veloutés"),
    Produit(
        id: _uuid.v4(),
        nom: "Soupe de Chou-Fleur Carotte au Cumin",
        prix: 3.20,
        quantite: 0,
        categorie: "Soupes et veloutés"),
    Produit(
        id: _uuid.v4(),
        nom: "Jus de pomme",
        prix: 2.40,
        quantite: 0,
        categorie: "Les jus de fruits"),
    Produit(
        id: _uuid.v4(),
        nom: "Jus de Poire",
        prix: 2.50,
        quantite: 0,
        categorie: "Les jus de fruits"),
    Produit(
        id: _uuid.v4(),
        nom: "Jus de Pomme Fraise",
        prix: 2.40,
        quantite: 0,
        categorie: "Les jus de fruits"),
    Produit(
        id: _uuid.v4(),
        nom: "Jus de Pomme Groseille",
        prix: 2.40,
        quantite: 0,
        categorie: "Les jus de fruits"),
    Produit(
        id: _uuid.v4(),
        nom: "Jus de Pomme Cerise",
        prix: 2.40,
        quantite: 0,
        categorie: "Les jus de fruits"),
    Produit(
        id: _uuid.v4(),
        nom: "Jus de Pomme Framboise",
        prix: 2.40,
        quantite: 0,
        categorie: "Les jus de fruits"),
    Produit(
        id: _uuid.v4(),
        nom: "Nectar de Kiwi",
        prix: 2.60,
        quantite: 0,
        categorie: "Les jus de fruits"),
    Produit(
        id: _uuid.v4(),
        nom: "Nectar de Pêche",
        prix: 2.60,
        quantite: 0,
        categorie: "Les jus de fruits"),
    Produit(
        id: _uuid.v4(),
        nom: "Nectar d'Abricot",
        prix: 2.80,
        quantite: 0,
        categorie: "Les jus de fruits"),
    Produit(
        id: _uuid.v4(),
        nom: "Compote de Pomme",
        prix: 3.20,
        quantite: 0,
        categorie: "Les compotes"),
    Produit(
        id: _uuid.v4(),
        nom: "Compote de Pomme Cannelle",
        prix: 3.20,
        quantite: 0,
        categorie: "Les compotes"),
    Produit(
        id: _uuid.v4(),
        nom: "Compote de Pomme Fraise",
        prix: 3.20,
        quantite: 0,
        categorie: "Les compotes"),
    Produit(
        id: _uuid.v4(),
        nom: "Compote de Pomme Orange Cannelle",
        prix: 3.20,
        quantite: 0,
        categorie: "Les compotes"),
    Produit(
        id: _uuid.v4(),
        nom: "Compote de Pomme Pêche",
        prix: 3.20,
        quantite: 0,
        categorie: "Les compotes"),
    Produit(
        id: _uuid.v4(),
        nom: "Compote de Pomme Abricot",
        prix: 3.20,
        quantite: 0,
        categorie: "Les compotes"),
    Produit(
        id: _uuid.v4(),
        nom: "Compote de Pomme Framboise",
        prix: 3.20,
        quantite: 0,
        categorie: "Les compotes"),
    Produit(
        id: _uuid.v4(),
        nom: "Confiture de Pomme Caramel au beurre salé",
        prix: 3.50,
        quantite: 0,
        categorie: "Les confitures"),
    Produit(
        id: _uuid.v4(),
        nom: "Confiture de Groseille",
        prix: 3.50,
        quantite: 0,
        categorie: "Les confitures"),
    Produit(
        id: _uuid.v4(),
        nom: "Confiture de Fraise",
        prix: 3.50,
        quantite: 0,
        categorie: "Les confitures"),
    Produit(
        id: _uuid.v4(),
        nom: "Confiture de Framboise",
        prix: 3.80,
        quantite: 0,
        categorie: "Les confitures"),
    Produit(
        id: _uuid.v4(),
        nom: "Confiture de Framboise à la Violette",
        prix: 3.80,
        quantite: 0,
        categorie: "Les confitures"),
    Produit(
        id: _uuid.v4(),
        nom: "Confiture de Fraise Basilic",
        prix: 3.50,
        quantite: 0,
        categorie: "Les confitures"),
    Produit(
        id: _uuid.v4(),
        nom: "Confiture d'Abricot",
        prix: 3.40,
        quantite: 0,
        categorie: "Les confitures"),
    Produit(
        id: _uuid.v4(),
        nom: "Confiture de Potiron Abricot Sec",
        prix: 3.40,
        quantite: 0,
        categorie: "Les confitures"),
    Produit(
        id: _uuid.v4(),
        nom: "Confiture de Pomme Potiron",
        prix: 3.40,
        quantite: 0,
        categorie: "Les confitures"),
    Produit(
        id: _uuid.v4(),
        nom: "Confiture de Pêche de vigne",
        prix: 3.40,
        quantite: 0,
        categorie: "Les confitures"),
    Produit(
        id: _uuid.v4(),
        nom: "Confiture de Pomme Poire aux épices",
        prix: 3.40,
        quantite: 0,
        categorie: "Les confitures"),
    Produit(
        id: _uuid.v4(),
        nom: "Confiture de Cassis",
        prix: 3.50,
        quantite: 0,
        categorie: "Les confitures"),
    Produit(
        id: _uuid.v4(),
        nom: "Sachet de 3kg",
        prix: 4.00,
        quantite: 0,
        categorie: "Pommes et poires"),
    Produit(
        id: _uuid.v4(),
        nom: "Poires au kg",
        prix: 1.90,
        quantite: 0,
        categorie: "Pommes et poires"),
    Produit(
        id: _uuid.v4(),
        nom: "Pommes au kg",
        prix: 1.70,
        quantite: 0,
        categorie: "Pommes et poires"),
    Produit(
        id: _uuid.v4(),
        nom: "Ratatouille (750 mL)",
        prix: 4.80,
        quantite: 0,
        categorie: "Les produits divers"),
    Produit(
        id: _uuid.v4(),
        nom: "Coulis de Tomate (250 mL)",
        prix: 2.80,
        quantite: 0,
        categorie: "Les produits divers"),
  ]);
});
