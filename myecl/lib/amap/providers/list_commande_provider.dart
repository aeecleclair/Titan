import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/commande.dart';
import 'package:myecl/amap/class/produit.dart';
import 'package:uuid/uuid.dart';

var _uuid = const Uuid();

class ListeCommandeNotifier extends StateNotifier<List<Commande>> {
  ListeCommandeNotifier([List<Commande>? listCmd]) : super(listCmd ?? []);

  void addProduit(int i, Produit p) {
    state[i].produits.add(p.copy());
  }

  void removeProduits(int i, Produit p) {
    state[i].produits.removeWhere((element) => element.nom == p.nom);
  }

  void removeCommande(int i) {
    state = state.sublist(0)..removeAt(i);
  }

  void addCommande(DateTime date, List<Produit> produits) {
    state = [
      ...state,
      Commande(
        id: _uuid.v4(),
        date: date,
        produits: produits,
      ),
    ];
  }

  void setProduitQuantite(int i, Produit p, int quantite) {
    List<Commande> r = state.sublist(0);

    for (int j = 0; j < r[i].produits.length; j++) {
      if (r[i].produits[j].id == p.id) {
        r[i].produits[j].quantite = quantite;
      }
    }

    state = r;
  }

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

  double getPrix(int i) {
    return state[i]
        .produits
        .map((e) => e.prix * e.quantite)
        .reduce((value, element) => value + element);
  }
}

final listCommandeProvider =
    StateNotifierProvider<ListeCommandeNotifier, List<Commande>>((ref) {
  return ListeCommandeNotifier([]);
});
