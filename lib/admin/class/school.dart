import 'package:titan/admin/tools/function.dart';

class School {
  School({required this.name, required this.id, required this.emailRegex});
  late final String name;
  late final String id;
  late final String emailRegex;

  School.fromJson(Map<String, dynamic> json) {
    name = getSchoolNameFromId(json['id'], json['name']);
    id = json['id'];
    emailRegex = json['email_regex'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['email_regex'] = emailRegex;
    return data;
  }

  School copyWith({String? name, String? id, String? emailRegex}) => School(
    name: name ?? this.name,
    id: id ?? this.id,
    emailRegex: emailRegex ?? this.emailRegex,
  );

  School.empty() {
    name = 'Nom';
    id = '';
    emailRegex = '';
  }

  @override
  String toString() {
    return 'School(id: $id, name: $name, emailRegex: $emailRegex)';
  }
}
