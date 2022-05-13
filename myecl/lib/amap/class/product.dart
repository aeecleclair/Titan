class Product {
  Product({
    required this.id,
    required this.nom,
    required this.prix,
    required this.quantite,
    required this.categorie,
  });
  late final String id;
  late final String nom;
  late final double prix;
  late final int quantite;
  late final String categorie;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    prix = json['prix'];
    quantite = json['quantite'];
    categorie = json['categorie'];
  }
  Product copy({id, nom, prix, quantite, categorie}) => Product(
        id: id ?? this.id,
        nom: nom ?? this.nom,
        prix: prix ?? this.prix,
        quantite: quantite ?? this.quantite,
        categorie: categorie ?? this.categorie,
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nom'] = nom;
    _data['prix'] = prix;
    _data['quantite'] = quantite;
    _data['categorie'] = categorie;
    return _data;
  }
}
