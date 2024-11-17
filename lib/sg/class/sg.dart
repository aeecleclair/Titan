class Sg {
  Sg({
    required this.name,
    required this.id,
    required this.openDate,
    required this.closeDate,
  });
  late final String name;
  late final String id;
  late final DateTime openDate;
  late final DateTime closeDate;

  Sg.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }

  Sg copyWith({String? name, String? groupManagerId, String? id}) {
    return Sg(
      name: name ?? this.name,
      id: id ?? this.id,
      openDate: openDate,
      closeDate: closeDate,
    );
  }

  Sg.empty() {
    name = "";
    id = "";
  }

  @override
  String toString() {
    return 'Sg(name: $name, id: $id)';
  }
}
