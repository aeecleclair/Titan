import 'package:myecl/purchases/class/seller.dart';
import 'package:myecl/tools/functions.dart';

class Purchase {
  Purchase({
    required this.id,
    required this.name,
    required this.description,
    required this.validated,
    required this.seller,
    required this.purchasedOn,
  });

  late final String id;
  late final String name;
  late final String description;
  late final bool validated;
  late final Seller seller;
  late final DateTime purchasedOn;

  Purchase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    validated = json['validated'];
    seller = Seller.fromJson(json['seller']);
    purchasedOn = processDateFromAPI(json['purchased_on']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'validated': validated,
      'seller': seller.toJson(),
      'purchasedOn': processDateToAPI(purchasedOn),
    };
    return data;
  }

  Purchase copyWith({
    String? id,
    String? name,
    String? description,
    bool? validated,
    Seller? seller,
    DateTime? purchasedOn,
  }) {
    return Purchase(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      validated: validated ?? this.validated,
      seller: seller ?? this.seller,
      purchasedOn: purchasedOn ?? this.purchasedOn,
    );
  }

  Purchase.empty() {
    id = "";
    name = "";
    description = "";
    validated = false;
    seller = Seller.empty();
    purchasedOn = DateTime.now();
  }

  @override
  String toString() {
    return 'Purchase(id: $id, name: $name, description: $description, validated: $validated, seller: $seller, purchasedOn: $purchasedOn)';
  }
}
