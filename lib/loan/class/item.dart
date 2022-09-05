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
        json['suggested_lending_duration'] / (60 * 60 * 24);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['suggested_caution'] = caution;
    _data['available'] = available;
    _data['suggested_lending_duration'] = suggestedLendingDuration * (60 * 60 * 24);
    return _data;
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
}
