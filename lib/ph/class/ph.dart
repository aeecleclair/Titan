import 'package:titan/tools/functions.dart';

class Ph {
  Ph({required this.id, required this.date, required this.name});
  late final String id;
  late final DateTime date;
  late final String name;

  Ph.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = processDateFromAPIWithoutHour(json['release_date']);
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['release_date'] = processDateToAPIWithoutHour(date);
    data['name'] = name;
    return data;
  }

  Ph copyWith({String? id, DateTime? date, String? name}) {
    return Ph(
      id: id ?? this.id,
      date: date ?? this.date,
      name: name ?? this.name,
    );
  }

  Ph.empty() {
    id = '';
    date = DateTime.now();
    name = '';
  }

  @override
  String toString() {
    return 'Ph{phId : $id, date: $date, name : $name}';
  }
}
