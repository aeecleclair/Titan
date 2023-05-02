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

  ItemSimple simple() {
    return ItemSimple(id: id,name: name);
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


class ItemSimple {
  ItemSimple({
    required this.id,
    required this.name,
  });
  late final String id;
  late final String name;

  ItemSimple.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  ItemSimple copyWith({id, name}) {
    return ItemSimple(
        id: id ?? this.id,
        name: name ?? this.name,);
  }

  ItemSimple.empty() {
    id = '';
    name = '';
  }

  @override
  String toString() {
    return 'ItemSimple(id: $id, name: $name';
  }
}



class ItemQuantity {
  ItemQuantity({
    required this.itemSimple,
    required this.quantity
  });
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

  ItemQuantity copyWith({itemSimple, quantity}) {
    return ItemQuantity(
        itemSimple: itemSimple ?? this.itemSimple,
        quantity: quantity ?? this.quantity);
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
