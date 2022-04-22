class Product {
  final String id;

  final String nom;

  final double prix;

  int quantite;

  final String categorie;

  Product({
    required this.id,
    required this.nom,
    required this.prix,
    required this.quantite,
    required this.categorie,
  });

  Product copy({id, nom, prix, quantite, categorie}) => Product(
        id: id ?? this.id,
        nom: nom ?? this.nom,
        prix: prix ?? this.prix,
        quantite: quantite ?? this.quantite,
        categorie: categorie ?? this.categorie,
      );
}
