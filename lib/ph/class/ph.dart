import 'package:myecl/ph/class/ph_admin.dart';
import 'package:myecl/tools/functions.dart';

class Ph {
  Ph({
    required this.id,
    required this.date,
    required this.name,
  });
  late final String id;
  late final DateTime date;
  late final String name;

  Ph.fromJson(Map<String, dynamic> json) {
    date = processDateFromAPIWithoutHour(json['release_date']);
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['release_date'] = processDateToAPIWithoutHour(date);
    data['name'] = name;
    return data;
  }

  Ph copyWith({String? id, PhAdmin? phAdmin, String? title}) {
    return Ph(id: id, date: date, name: name);
  }

  Ph.empty() {
    date = DateTime.now();
    name = '';
  }

  @override
  String toString() {
    return 'Ph(date: $date, name : $name)';
  }
}
