import 'package:myecl/loan/class/item_simple.dart';

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
    id = json['id'] as String;
    name = json['name'] as String;
    caution = json['suggested_caution'] as int;
    totalQuantity = json['total_quantity'] as int;
    loanedQuantity = json['loaned_quantity'] as int;
    suggestedLendingDuration = json['suggested_lending_duration'] as double;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['suggested_caution'] = caution;
    data['total_quantity'] = totalQuantity;
    data['loaned_quantity'] = loanedQuantity;
    data['suggested_lending_duration'] = suggestedLendingDuration;
    return data;
  }

  Item copyWith(
      {String? id,
      String? name,
      int? caution,
      int? totalQuantity,
      int? loanedQuantity,
      double? suggestedLendingDuration}) {
    return Item(
        id: id ?? this.id,
        name: name ?? this.name,
        caution: caution ?? this.caution,
        totalQuantity: totalQuantity ?? this.totalQuantity,
        loanedQuantity: loanedQuantity ?? this.loanedQuantity,
        suggestedLendingDuration:
            suggestedLendingDuration ?? this.suggestedLendingDuration);
  }

  ItemSimple toItemSimple() {
    return ItemSimple(id: id, name: name);
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
    return 'Item(id: $id, name: $name, caution: $caution, totalQuantity: $totalQuantity, loanedQuantity: $loanedQuantity, suggestedLendingDuration: $suggestedLendingDuration)';
  }
}
