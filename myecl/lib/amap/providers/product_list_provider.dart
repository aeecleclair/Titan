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

  Future<bool> addProduct(Product product) async {
    try {
      if (await _productListRepository.createProduct(product)) {
        lastLoadedProducts.add(product);
        state = AsyncValue.data(lastLoadedProducts);
        return true;
      } else {
        state = AsyncValue.error(Exception("Failed to add product"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return false;
  }

  Future<bool> updateProduct(
      String productId, Product product) async {
    try {
      if (await _productListRepository.updateProduct(productId, product)) {
        lastLoadedProducts.replaceRange(
            lastLoadedProducts.indexOf(lastLoadedProducts
                .firstWhere((element) => element.id == productId)),
            1,
            [product]);
        state = AsyncData(lastLoadedProducts);
        return true;
      } else {
        state = AsyncValue.error(Exception("Failed to update product"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return false;
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      if (await _productListRepository.deleteProduct(productId)) {
        lastLoadedProducts.remove(lastLoadedProducts
            .firstWhere((element) => element.id == productId));
        state = AsyncData(lastLoadedProducts);
        return true;
      } else {
        state = AsyncValue.error(Exception("Failed to delete product"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return false;
  }

  Future<bool> setQuantity(String productId, int i) async {
    try {
      lastLoadedProducts
          .firstWhere((element) => element.id == productId)
          .quantity = i;
      state = AsyncData(lastLoadedProducts);
      return true;
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return false;
  }

  Future<bool> resetQuantity() async {
    try {
      for (var element in lastLoadedProducts) {
        element.quantity = 0;
      }
      state = AsyncData(lastLoadedProducts);
      return true;
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return false;
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
  //       name: "Panier de fruits et légumes pour 2",
  //       price: 10.20,
  //       quantity: 0,
  //       category: "Les paniers"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Panier de fruits et légumes pour 4",
  //       price: 16.20,
  //       quantity: 0,
  //       category: "Les paniers"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Panier de fruits",
  //       price: 10.20,
  //       quantity: 0,
  //       category: "Les paniers"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "6 oeufs",
  //       price: 1.80,
  //       quantity: 0,
  //       category: "Les oeufs"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "12 oeufs",
  //       price: 3.30,
  //       quantity: 0,
  //       category: "Les oeufs"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Velouté de courgette",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Velouté de Butternut au curry",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Soupe de Courge",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Soupe de Potimarron",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Soupe de Carotte Tomate",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Soupe de Brocoli Courgette",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Soupe à l'oignon",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Soupe de Carotte au Cumin",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Soupe de légumes",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Soupe de Chou-Fleur Carotte au Cumin",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Soupes et veloutés"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Jus de pomme",
  //       price: 2.40,
  //       quantity: 0,
  //       category: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Jus de Poire",
  //       price: 2.50,
  //       quantity: 0,
  //       category: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Jus de Pomme Fraise",
  //       price: 2.40,
  //       quantity: 0,
  //       category: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Jus de Pomme Groseille",
  //       price: 2.40,
  //       quantity: 0,
  //       category: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Jus de Pomme Cerise",
  //       price: 2.40,
  //       quantity: 0,
  //       category: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Jus de Pomme Framboise",
  //       price: 2.40,
  //       quantity: 0,
  //       category: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Nectar de Kiwi",
  //       price: 2.60,
  //       quantity: 0,
  //       category: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Nectar de Pêche",
  //       price: 2.60,
  //       quantity: 0,
  //       category: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Nectar d'Abricot",
  //       price: 2.80,
  //       quantity: 0,
  //       category: "Les jus de fruits"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Compote de Pomme",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Les compotes"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Compote de Pomme Cannelle",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Les compotes"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Compote de Pomme Fraise",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Les compotes"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Compote de Pomme Orange Cannelle",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Les compotes"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Compote de Pomme Pêche",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Les compotes"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Compote de Pomme Abricot",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Les compotes"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Compote de Pomme Framboise",
  //       price: 3.20,
  //       quantity: 0,
  //       category: "Les compotes"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Confiture de Pomme Caramel au beurre salé",
  //       price: 3.50,
  //       quantity: 0,
  //       category: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Confiture de Groseille",
  //       price: 3.50,
  //       quantity: 0,
  //       category: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Confiture de Fraise",
  //       price: 3.50,
  //       quantity: 0,
  //       category: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Confiture de Framboise",
  //       price: 3.80,
  //       quantity: 0,
  //       category: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Confiture de Framboise à la Violette",
  //       price: 3.80,
  //       quantity: 0,
  //       category: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Confiture de Fraise Basilic",
  //       price: 3.50,
  //       quantity: 0,
  //       category: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Confiture d'Abricot",
  //       price: 3.40,
  //       quantity: 0,
  //       category: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Confiture de Potiron Abricot Sec",
  //       price: 3.40,
  //       quantity: 0,
  //       category: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Confiture de Pomme Potiron",
  //       price: 3.40,
  //       quantity: 0,
  //       category: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Confiture de Pêche de vigne",
  //       price: 3.40,
  //       quantity: 0,
  //       category: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Confiture de Pomme Poire aux épices",
  //       price: 3.40,
  //       quantity: 0,
  //       category: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Confiture de Cassis",
  //       price: 3.50,
  //       quantity: 0,
  //       category: "Les confitures"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Sachet de 3kg",
  //       price: 4.00,
  //       quantity: 0,
  //       category: "Pommes et poires"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Poires au kg",
  //       price: 1.90,
  //       quantity: 0,
  //       category: "Pommes et poires"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Pommes au kg",
  //       price: 1.70,
  //       quantity: 0,
  //       category: "Pommes et poires"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Ratatouille (750 mL)",
  //       price: 4.80,
  //       quantity: 0,
  //       category: "Les produits divers"),
  //   Product(
  //       id: _uuid.v4(),
  //       name: "Coulis de Tomate (250 mL)",
  //       price: 2.80,
  //       quantity: 0,
  //       category: "Les produits divers"),
  // ]);
});
