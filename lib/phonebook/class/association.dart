class Association{
  Association({
    required this.id,
    required this.name,
  });
  
  late final String id;
  late final String name;

  Association.fromJSON(Map<String, dynamic> json){
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

  Association copyWith({
    String? id,
    String? name,
  }) {
    return Association(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Association.empty(){
    id = "";
    name = "";
  }
}