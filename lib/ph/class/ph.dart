import 'package:myecl/ph/class/ph_admin.dart';

class Ph {
  Ph({
    required this.id,
    required this.phAdmin,
    required this.title,
  });
  late final String id;
  late final PhAdmin phAdmin;
  late final String title;

  Ph.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phAdmin = PhAdmin.fromJson(json['ph_admin']);
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['phAdmin'] = phAdmin;
    data['title'] = title;
    return data;
  }

  Ph copyWith({String? id, PhAdmin? phAdmin, String? title}) {
    return Ph(
        id: id ?? this.id,
        phAdmin: phAdmin ?? this.phAdmin,
        title: title ?? this.title);
  }

  Ph.empty() {
    id = '';
    phAdmin = PhAdmin.empty();
    title = '';
  }

  @override
  String toString() {
    return 'Ph(id: $id, ph_admin: $phAdmin, title : $title)';
  }
}
