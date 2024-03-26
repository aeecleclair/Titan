import 'package:myecl/ph/class/ph_admin.dart';

class Ph {
  Ph({
    required this.id,
    required this.date,
    required this.title,
  });
  late final String id;
  late final DateTime date;
  late final String title;

  Ph.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['title'] = title;
    return data;
  }

  Ph copyWith({String? id, PhAdmin? phAdmin, String? title}) {
    return Ph(id: id ?? this.id, date: date, title: title ?? this.title);
  }

  Ph.empty() {
    id = '';
    date = DateTime.now();
    title = '';
  }

  @override
  String toString() {
    return 'Ph(id: $id, date: $date, title : $title)';
  }
}
