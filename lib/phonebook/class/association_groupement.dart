class AssociationGroupement {
  AssociationGroupement({required this.id, required this.name});

  late final String id;
  late final String name;

  AssociationGroupement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{'id': id, 'name': name};
    return data;
  }

  AssociationGroupement.empty() {
    id = "";
    name = "";
  }

  @override
  String toString() {
    return 'AssociationGroupement(kinds: $id, name: $name)';
  }
}
