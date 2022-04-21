/// La classe représentant un produit
class Produit {
  /// Son identifiant
  final String id;

  /// Son nom
  final String nom;

  /// Son prix
  final double prix;

  /// Sa quantité commandé (il n'est pas final car setProduitQuantite doit pouvoir le modifier)
  int quantite;

  /// Sa catégorie
  final String categorie;

  /// Initialisation de la classe
  Produit({
    required this.id,
    required this.nom,
    required this.prix,
    required this.quantite,
    required this.categorie,
  });

  /// Copie le produit, pour éviter les alias
  Produit copy({id, nom, prix, quantite, categorie}) => Produit(
        id: id ?? this.id,
        nom: nom ?? this.nom,
        prix: prix ?? this.prix,
        quantite: quantite ?? this.quantite,
        categorie: categorie ?? this.categorie,
      );
}
