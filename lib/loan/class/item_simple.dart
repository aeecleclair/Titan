class ItemSimple {
  ItemSimple({required this.id, required this.name});
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

  ItemSimple copyWith({String? id, String? name}) {
    return ItemSimple(id: id ?? this.id, name: name ?? this.name);
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
