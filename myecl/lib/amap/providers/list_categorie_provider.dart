import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/providers/list_produit_provider.dart';

class ListeCategorieNotifier extends StateNotifier<List<String>> {
  ListeCategorieNotifier([List<String>? cmds]) : super(cmds ?? []);

  void ajouterCategorie(String c) {
    state = [...state, c]..sort();
  }

  void removeCategorie(String c) {
    state = state.sublist(0)..remove(c);
  }
}

final listeCategorieProvider =
    StateNotifierProvider<ListeCategorieNotifier, List<String>>((ref) {
  final produits = ref.watch(listeProduitprovider);

  return ListeCategorieNotifier([
    ...{...produits.map((e) => e.categorie)}
  ]..sort());
});
