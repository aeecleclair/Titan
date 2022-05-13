import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/repositories/product_list_repository.dart';

class ProductListNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductListRepository _productListRepository = ProductListRepository();
  List<Product> lastLoadedProducts = [];
  ProductListNotifier() : super(const AsyncValue.loading());

  Future<AsyncValue<List<Product>>> loadProductList() async {
    try {
      final productList = await _productListRepository.getAllProducts();
      lastLoadedProducts = productList;
      state = AsyncValue.data(productList);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<AsyncValue<List<Product>>> addProduct(Product product) async {
    try {
      if (await _productListRepository.createProduct(product)) {
        lastLoadedProducts.add(product);
        state = AsyncValue.data(lastLoadedProducts);
      } else {
        state = AsyncValue.error(Exception("Failed to add product"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<AsyncValue<List<Product>>> updateProduct(String productId, Product product) async {
    try {
      if (await _productListRepository.updateProduct(productId, product)) {
        lastLoadedProducts.replaceRange(lastLoadedProducts.indexOf(lastLoadedProducts.firstWhere((element) => element.id == productId)), 1, [product]);
        state = AsyncData(lastLoadedProducts);
      } else {
        state = AsyncValue.error(Exception("Failed to update product"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<AsyncValue<List<Product>>> deleteProduct(String productId) async {
    try {
      if (await _productListRepository.deleteProduct(productId)) {
        lastLoadedProducts.remove(lastLoadedProducts.firstWhere((element) => element.id == productId));
        state = AsyncData(lastLoadedProducts);
      } else {
        state = AsyncValue.error(Exception("Failed to delete product"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<AsyncValue<List<Product>>> setQuantity(String productId, int i) async {
    try {
      lastLoadedProducts
          .firstWhere((element) => element.id == productId)
          .quantite = i;
      state = AsyncData(lastLoadedProducts);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<AsyncValue<List<Product>>> resetQuantity() async {
    try {
      for (var element in lastLoadedProducts) {
        element.quantite = 0;
      }
      state = AsyncData(lastLoadedProducts);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }
}

final productListProvider =
    StateNotifierProvider<ProductListNotifier, AsyncValue<List<Product>>>(
        (ref) {
  ProductListNotifier _productListNotifier = ProductListNotifier();
  _productListNotifier.loadProductList();
  return _productListNotifier;
  // return ProductListNotifier([
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Panier de fruits et légumes pour 2",
  //       prix: 10.20,
  //       quantite: 0,
  //       categorie: "Les paniers"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Panier de fruits et légumes pour 4",
  //       prix: 16.20,
  //       quantite: 0,
  //       categorie: "Les paniers"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Panier de fruits",
  //       prix: 10.20,
  //       quantite: 0,
  //       categorie: "Les paniers"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "6 oeufs",
  //       prix: 1.80,
  //       quantite: 0,
  //       categorie: "Les oeufs"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "12 oeufs",
  //       prix: 3.30,
  //       quantite: 0,
  //       categorie: "Les oeufs"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Velouté de courgette",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Velouté de Butternut au curry",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Soupe de Courge",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Soupe de Potimarron",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Soupe de Carotte Tomate",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Soupe de Brocoli Courgette",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Soupe à l'oignon",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Soupe de Carotte au Cumin",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Soupe de légumes",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Soupe de Chou-Fleur Carotte au Cumin",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Jus de pomme",
  //       prix: 2.40,
  //       quantite: 0,
  //       categorie: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Jus de Poire",
  //       prix: 2.50,
  //       quantite: 0,
  //       categorie: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Jus de Pomme Fraise",
  //       prix: 2.40,
  //       quantite: 0,
  //       categorie: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Jus de Pomme Groseille",
  //       prix: 2.40,
  //       quantite: 0,
  //       categorie: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Jus de Pomme Cerise",
  //       prix: 2.40,
  //       quantite: 0,
  //       categorie: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Jus de Pomme Framboise",
  //       prix: 2.40,
  //       quantite: 0,
  //       categorie: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Nectar de Kiwi",
  //       prix: 2.60,
  //       quantite: 0,
  //       categorie: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Nectar de Pêche",
  //       prix: 2.60,
  //       quantite: 0,
  //       categorie: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Nectar d'Abricot",
  //       prix: 2.80,
  //       quantite: 0,
  //       categorie: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Compote de Pomme",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Les compotes"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Compote de Pomme Cannelle",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Les compotes"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Compote de Pomme Fraise",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Les compotes"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Compote de Pomme Orange Cannelle",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Les compotes"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Compote de Pomme Pêche",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Les compotes"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Compote de Pomme Abricot",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Les compotes"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Compote de Pomme Framboise",
  //       prix: 3.20,
  //       quantite: 0,
  //       categorie: "Les compotes"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Confiture de Pomme Caramel au beurre salé",
  //       prix: 3.50,
  //       quantite: 0,
  //       categorie: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Confiture de Groseille",
  //       prix: 3.50,
  //       quantite: 0,
  //       categorie: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Confiture de Fraise",
  //       prix: 3.50,
  //       quantite: 0,
  //       categorie: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Confiture de Framboise",
  //       prix: 3.80,
  //       quantite: 0,
  //       categorie: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Confiture de Framboise à la Violette",
  //       prix: 3.80,
  //       quantite: 0,
  //       categorie: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Confiture de Fraise Basilic",
  //       prix: 3.50,
  //       quantite: 0,
  //       categorie: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Confiture d'Abricot",
  //       prix: 3.40,
  //       quantite: 0,
  //       categorie: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Confiture de Potiron Abricot Sec",
  //       prix: 3.40,
  //       quantite: 0,
  //       categorie: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Confiture de Pomme Potiron",
  //       prix: 3.40,
  //       quantite: 0,
  //       categorie: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Confiture de Pêche de vigne",
  //       prix: 3.40,
  //       quantite: 0,
  //       categorie: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Confiture de Pomme Poire aux épices",
  //       prix: 3.40,
  //       quantite: 0,
  //       categorie: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Confiture de Cassis",
  //       prix: 3.50,
  //       quantite: 0,
  //       categorie: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Sachet de 3kg",
  //       prix: 4.00,
  //       quantite: 0,
  //       categorie: "Pommes et poires"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Poires au kg",
  //       prix: 1.90,
  //       quantite: 0,
  //       categorie: "Pommes et poires"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Pommes au kg",
  //       prix: 1.70,
  //       quantite: 0,
  //       categorie: "Pommes et poires"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Ratatouille (750 mL)",
  //       prix: 4.80,
  //       quantite: 0,
  //       categorie: "Les produits divers"),
  //   Product(
  //       id: _uuid.v4(),
  //       nom: "Coulis de Tomate (250 mL)",
  //       prix: 2.80,
  //       quantite: 0,
  //       categorie: "Les produits divers"),
  // ]);
});
