import 'package:myecl/ph/class/ph_admin.dart';

class Ph {
  Ph({
    required this.date,
    required this.name,
  });
  late final String date;
  late final String name;

  Ph.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    name = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['title'] = name;
    return data;
  }

  Ph copyWith({String? id, PhAdmin? phAdmin, String? title}) {
    return Ph(date: date, name: name);
  }

  Ph.empty() {
    date = '';
    name = '';
  }

  @override
  String toString() {
    return 'Ph(date: $date, name : $name)';
  }
}
