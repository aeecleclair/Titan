import 'package:myecl/tools/functions.dart';

class CMM {
  CMM({
    required this.id,
    required this.date,
    required this.userId,
  });
  late final String id;
  late final DateTime date;
  late final String userId;

  CMM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = processDateFromAPIWithoutHour(json['release_date']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['release_date'] = processDateToAPIWithoutHour(date);
    return data;
  }

  CMM.empty() {
    id = '';
    date = DateTime.now();
  }

  @override
  String toString() {
    return 'CMM{cmmId : $id, date: $date,}';
  }
}
