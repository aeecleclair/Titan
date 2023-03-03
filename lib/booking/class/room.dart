class Room {
  late final String name;
  late final String id;

  Room({required this.name, required this.id});

  Room.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["name"] = name;
    data["id"] = id;
    return data;
  }

  Room copyWith({name, id}) {
    return Room(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Room.empty() : this(name: '', id: '');

  @override
  String toString() {
    return 'Room{name: $name, id: $id}';
  }
}
