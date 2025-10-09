import 'package:titan/loan/class/item_simple.dart';

class ItemQuantity {
  ItemQuantity({required this.itemSimple, required this.quantity});
  late final ItemSimple itemSimple;
  late final int quantity;

  ItemQuantity.fromJson(Map<String, dynamic> json) {
    itemSimple = ItemSimple.fromJson(json['itemSimple']);
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['item_id'] = itemSimple.id;
    data['quantity'] = quantity;
    return data;
  }

  ItemQuantity copyWith({ItemSimple? itemSimple, int? quantity}) {
    return ItemQuantity(
      itemSimple: itemSimple ?? this.itemSimple,
      quantity: quantity ?? this.quantity,
    );
  }

  ItemQuantity.empty() {
    itemSimple = ItemSimple.empty();
    quantity = 0;
  }

  @override
  String toString() {
    return 'ItemQuantity(itemSimple: $itemSimple, quantity: $quantity)';
  }
}
