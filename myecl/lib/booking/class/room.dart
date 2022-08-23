class Room {
  late final String name;
  late final String id;

  Room({required this.name, required this.id});

  Room.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["name"] = name;
    _data["id"] = id;
    return _data;
  }

  Room copyWith({name, id}) {
    return Room(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Room.empty() : this(name: '', id: '');
}