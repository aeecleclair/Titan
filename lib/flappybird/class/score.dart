import 'package:myecl/tools/functions.dart';
import 'package:myecl/user/class/list_users.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Score {
  late final SimpleUser user;
  late final int value;
  late final int key;
  late final DateTime date;
  late final int position;

  Score({
    required this.user,
    required this.value,
    required this.key,
    required this.date,
    required this.position,
  });

  static int genKey(int value) {
    final data = "$value";
    final bytes = utf8.encode(data);
    final hash = sha256.convert(bytes);
    final hashBytes = hash.bytes;

    return hashBytes.sublist(0, 4).fold(0, (acc, byte) => (acc << 8) + byte);
  }

  Score.fromJson(Map<String, dynamic> json, {int? index = 0}) {
    user = SimpleUser.fromJson(json['user']);
    value = json['value'];
    key = json['key'];
    date = processDateFromAPI(json['creation_time']);
    position = json['position'] ?? index;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = user.id;
    data['value'] = value;
    data['key'] = key;
    return data;
  }

  Score copyWith({
    SimpleUser? user,
    int? value,
    int? key,
    DateTime? date,
    int? position,
  }) {
    return Score(
      user: user ?? this.user,
      value: value ?? this.value,
      key: key ?? this.key,
      date: date ?? this.date,
      position: position ?? this.position,
    );
  }

  Score.empty() {
    user = SimpleUser.empty();
    value = 0;
    key = genKey(0);
    date = DateTime.now();
    position = 0;
  }

  @override
  String toString() =>
      'Score(user: $user, value: $value, key: $key, date: $date, position: $position)';
}
