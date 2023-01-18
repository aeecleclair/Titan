class Item {
  Item({
    required this.id,
    required this.name,
    required this.caution,
    required this.available,
    required this.suggestedLendingDuration,
  });
  late final String id;
  late final String name;
  late final int caution;
  late final bool available;
  late final double suggestedLendingDuration;

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    caution = json['suggested_caution'];
    available = json['available'];
    suggestedLendingDuration =
        json['suggested_lending_duration'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['suggested_caution'] = caution;
    data['available'] = available;
    data['suggested_lending_duration'] = suggestedLendingDuration;
    return data;
  }

  Item copyWith({id, name, caution, available, suggestedLendingDuration}) {
    return Item(
        id: id ?? this.id,
        name: name ?? this.name,
        caution: caution ?? this.caution,
        available: available ?? this.available,
        suggestedLendingDuration:
            suggestedLendingDuration ?? this.suggestedLendingDuration);
  }

  Item.empty() {
    id = '';
    name = '';
    caution = 0;
    available = false;
    suggestedLendingDuration = 0;
  }

  @override
  String toString() {
    return 'Item(id: $id, name: $name, caution: $caution, available: $available, suggestedLendingDuration: $suggestedLendingDuration)';
  }
}
