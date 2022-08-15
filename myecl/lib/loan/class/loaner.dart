class Loaner {
  Loaner({
    required this.name,
    required this.id,
  });
  late final String name;
  late final String id;

  Loaner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    return _data;
  }

  Loaner copyWith({name, id}) {
    return Loaner(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}
