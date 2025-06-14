import 'package:titan/purchases/class/product.dart';
import 'package:titan/purchases/class/seller.dart';
import 'package:titan/tools/functions.dart';

class Purchase {
  Purchase({
    required this.quantity,
    required this.productVariantId,
    required this.validated,
    required this.purchasedOn,
    required this.price,
    required this.product,
    required this.seller,
  });

  late final int quantity;
  late final String productVariantId;
  late final bool validated;
  late final DateTime purchasedOn;
  late final int price;
  late final Product product;
  late final Seller seller;

  Purchase.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    productVariantId = json['product_variant_id'];
    validated = json['validated'];
    seller = Seller.fromJson(json['seller']);
    purchasedOn = processDateFromAPI(json['purchased_on']);
    price = json['price'];
    product = Product.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'quantity': quantity,
      'product_variant_id': productVariantId,
      'validated': validated,
      'seller': seller.toJson(),
      'purchasedOn': processDateToAPI(purchasedOn),
      'price': price,
      'product': product.toJson(),
    };
    return data;
  }

  Purchase copyWith({
    int? quantity,
    String? productVariantId,
    bool? validated,
    DateTime? purchasedOn,
    int? price,
    Product? product,
    Seller? seller,
  }) {
    return Purchase(
      quantity: quantity ?? this.quantity,
      productVariantId: productVariantId ?? this.productVariantId,
      validated: validated ?? this.validated,
      purchasedOn: purchasedOn ?? this.purchasedOn,
      price: price ?? this.price,
      product: product ?? this.product,
      seller: seller ?? this.seller,
    );
  }

  Purchase.empty() {
    quantity = 0;
    productVariantId = "";
    price = 0;
    product = Product.empty();
    validated = false;
    seller = Seller.empty();
    purchasedOn = DateTime.now();
  }

  @override
  String toString() {
    return 'Purchase(quantity: $quantity, productVariantId: $productVariantId, validated: $validated, purchasedOn: $purchasedOn, price: $price, product: $product, seller: $seller)';
  }
}
