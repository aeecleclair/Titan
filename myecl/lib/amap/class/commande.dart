import 'package:myecl/amap/class/produit.dart';

class Commande {
  final String id;

  final DateTime date;

  final List<Produit> produits;

  final bool expanded;

  Commande(
      {required this.id,
      required this.date,
      required this.produits,
      this.expanded = false});

  Commande copy({id, date, produits, expanded}) => Commande(
      id: id ?? this.id,
      date: date ?? this.date,
      produits: produits ?? this.produits,
      expanded: expanded ?? this.expanded);
}
