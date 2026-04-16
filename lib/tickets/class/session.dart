import 'package:titan/tools/functions.dart';

class Session {
  Session({
    required this.id,
    required this.name,
    required this.startDatetime,
    this.quota,
  });
  late final String id;
  late final String name;
  late final DateTime startDatetime;
  late final int? quota;

  Session.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    name = json['name']?.toString() ?? '';
    startDatetime = processDateFromAPI(json['start_datetime'] ?? '');
    quota = json['quota'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start_datetime'] = processDateToAPI(startDatetime);
    data['quota'] = quota;
    return data;
  }

  Session copyWith({
    String? id,
    String? name,
    DateTime? startDatetime,
    int? quota,
  }) {
    return Session(
      id: id ?? this.id,
      name: name ?? this.name,
      startDatetime: startDatetime ?? this.startDatetime,
      quota: quota ?? this.quota,
    );
  }

  Session.empty() {
    id = '';
    name = '';
    startDatetime = DateTime.now();
    quota = null;
  }

  @override
  String toString() {
    return 'Session{id : $id, name: $name, startDatetime: $startDatetime, quota: $quota}';
  }
}
