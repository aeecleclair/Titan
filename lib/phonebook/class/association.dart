class Association{
  Association({
    required this.id,
    required this.name,
    required this.description,
  });
  
  late final String id;
  late final String name;
  late final String description;

  Association.fromJSON(Map<String, dynamic> json){
      id = json['id'];
      name = json['name'];
      description = json['description'];
      }

  Map<String, dynamic> toJSON(){
    final data = <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
    };
    return data;
  }

  Association copyWith({
    String? id,
    String? name,
    String? description,
  }) {
    return Association(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Association.empty(){
    id = "";
    name = "";
    description = "";
  }

  @override
  String toString(){
    return "Nom : $name, id : $id, description : $description";
  }
}