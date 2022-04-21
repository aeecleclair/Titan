import 'package:myecl/amap/class/produit.dart';

/// La classe représentant une commande
class Commande {
  /// L'identifiant de la commande
  final String id;

  /// la date de fin de la commande
  final DateTime date;

  /// La liste des produits de la commadne
  final List<Produit> produits;

  /// Si la commande est affichée en entier dans la AmapPage des commandes
  final bool expanded;

  /// Initialisation de la commande
  Commande(
      {required this.id,
      required this.date,
      required this.produits,
      // Par défaut, l'affichage est un résumé
      this.expanded = false});

  /// Copie la commande, permet d'éviter un alias
  Commande copy({id, date, produits, expanded}) => Commande(
      id: id ?? this.id,
      date: date ?? this.date,
      produits: produits ?? this.produits,
      expanded: expanded ?? this.expanded);
}
