class Item {
  Item({
    required this.id,
    required this.name,
    required this.caution,
    required this.suggestedLendingDuration,
  });
  late final String id;
  late final String name;
  late final int caution;
  late final double suggestedLendingDuration;

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    caution = json['suggested_caution'];
    suggestedLendingDuration =
        json['suggested_lending_duration'] / (60 * 60 * 24);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['suggested_caution'] = caution;
    _data['suggested_lending_duration'] = suggestedLendingDuration;
    return _data;
  }

  Item copyWith({id, name, caution, suggestedLendingDuration}) {
    return Item(
        id: id ?? this.id,
        name: name ?? this.name,
        caution: caution ?? this.caution,
        suggestedLendingDuration:
            suggestedLendingDuration ?? this.suggestedLendingDuration);
  }
}
