class Room {
  final String name;
  final String managerId;
  final String id;

  Room({required this.name, required this.managerId, required this.id});

  Room.fromJson(Map<String, dynamic> json)
    : name = json["name"],
      managerId = json["manager_id"],
      id = json["id"];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["name"] = name;
    data["manager_id"] = managerId;
    data["id"] = id;
    return data;
  }

  Room copyWith({String? name, String? managerId, String? id}) {
    return Room(
      name: name ?? this.name,
      managerId: managerId ?? this.managerId,
      id: id ?? this.id,
    );
  }

  Room.empty() : this(name: '', managerId: '', id: '');

  @override
  String toString() {
    return 'Room{name: $name, manager_id: $managerId, id: $id}';
  }
}
