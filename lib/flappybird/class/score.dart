import 'package:titan/tools/functions.dart';
import 'package:titan/user/class/simple_users.dart';

class Score {
  late final SimpleUser user;
  late final int value;
  late final DateTime date;
  late final int position;

  Score({
    required this.user,
    required this.value,
    required this.date,
    required this.position,
  });

  Score.fromJson(Map<String, dynamic> json, {int? index = 0}) {
    user = SimpleUser.fromJson(json['user']);
    value = json['value'];
    date = processDateFromAPI(json['creation_time']);
    position = json['position'] ?? index;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = user.id;
    data['value'] = value;
    return data;
  }

  Score copyWith({
    SimpleUser? user,
    int? value,
    DateTime? date,
    int? position,
  }) {
    return Score(
      user: user ?? this.user,
      value: value ?? this.value,
      date: date ?? this.date,
      position: position ?? this.position,
    );
  }

  Score.empty() {
    user = SimpleUser.empty();
    value = 0;
    date = DateTime.now();
    position = 0;
  }

  @override
  String toString() =>
      'Score(user: $user, value: $value, date: $date, position: $position)';
}
