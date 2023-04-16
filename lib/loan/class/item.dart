class Item {
  Item({
    required this.id,
    required this.name,
    required this.caution,
    required this.totalQuantity,
    required this.loanedQuantity,
    required this.suggestedLendingDuration,
  });
  late final String id;
  late final String name;
  late final int caution;
  late final int totalQuantity;
  late final int loanedQuantity;
  late final double suggestedLendingDuration;

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    caution = json['suggested_caution'];
    totalQuantity = json['total_quantity'];
    loanedQuantity = json['loaned_quantity'];
    suggestedLendingDuration =
        json['suggested_lending_duration'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['suggested_caution'] = caution;
    data['total_quantity'] = totalQuantity;
    data['suggested_lending_duration'] = suggestedLendingDuration;
    return data;
  }

  Item copyWith({id, name, caution, totalQuantity,loanedQuantity, suggestedLendingDuration}) {
    return Item(
        id: id ?? this.id,
        name: name ?? this.name,
        caution: caution ?? this.caution,
        totalQuantity: totalQuantity ?? this.totalQuantity,
        loanedQuantity: loanedQuantity ?? this.loanedQuantity,
        suggestedLendingDuration:
            suggestedLendingDuration ?? this.suggestedLendingDuration);
  }

  Item.empty() {
    id = '';
    name = '';
    caution = 0;
    totalQuantity = 1;
    loanedQuantity = 0;
    suggestedLendingDuration = 0;
  }

  @override
  String toString() {
    return 'Item(id: $id, name: $name, caution: $caution, totalQuantity: $totalQuantity,  loanedQuantity: $loanedQuantity, suggestedLendingDuration: $suggestedLendingDuration)';
  }
}

class ItemQuantity {
  ItemQuantity({
    required this.item,
    required this.quantity
  });
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

  ItemQuantity copyWith({item, quantity, caution, totalQuantity,loanedQuantity, suggestedLendingDuration}) {
    return ItemQuantity(
        item: item ?? this.item,
        quantity: quantity ?? this.quantity);
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
