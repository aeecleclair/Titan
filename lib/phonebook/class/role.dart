class Role{
  Role({
    required this.id,
    required this.name,
    });
  
  late final String id;
  late final String name;

  Role.fromJSON(Map<String, dynamic> json){
      id = json['id'];
      name = json['name'];
      }
  
  Map<String, dynamic> toJSON(){
    final data = <String, dynamic>{
      'id': id,
      'name': name,
    };
    return data;
  }

  Role copyWith({
    String? id,
    String? name,
  }) {
    return Role(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Role.empty(){
    id = "";
    name = "";
  }
  
}