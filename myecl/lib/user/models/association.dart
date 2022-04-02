class Association {
  String? id;
  String? name;
  String? type;
  List<String>? users;
  List<String>? members;

  Association({this.id, this.name, this.type, this.users, this.members});

  Association.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    users = json['users'].cast<String>();
    members = json['members'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['users'] = users;
    data['members'] = members;
    return data;
  }
}
