import 'package:myecl/loan/class/item.dart';

class ItemQuantity {
  ItemQuantity({required this.item, required this.quantity});
  late final Item item;
  late final int quantity;

  ItemQuantity.fromJson(Map<String, dynamic> json) {
    item = Item.fromJson(json['item']);
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['item_id'] = item.id;
    data['quantity'] = quantity;
    return data;
  }

  ItemQuantity copyWith(
      {item,
      quantity,
      caution,
      totalQuantity,
      loanedQuantity,
      suggestedLendingDuration}) {
    return ItemQuantity(
        item: item ?? this.item, quantity: quantity ?? this.quantity);
  }

  ItemQuantity.empty() {
    item = Item.empty();
    quantity = 0;
  }

  @override
  String toString() {
    return 'ItemQuantity(item: $item, quantity: $quantity)';
  }
}
