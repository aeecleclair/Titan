import 'package:myecl/user/class/list_users.dart';

class CMMScore {
  late final SimpleUser user;
  late final int value;
  late final int position;

  CMMScore({
    required this.user,
    required this.value,
    required this.position,
  });

  CMMScore.fromJson(Map<String, dynamic> json, {int? index = 0}) {
    user = SimpleUser.fromJson(json['user']);
    value = json['value'];
    position = json['position'] ?? index;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = user.id;
    data['value'] = value;
    return data;
  }

  CMMScore copyWith({
    SimpleUser? user,
    int? value,
    DateTime? date,
    int? position,
  }) {
    return CMMScore(
      user: user ?? this.user,
      value: value ?? this.value,
      position: position ?? this.position,
    );
  }

  CMMScore.empty() {
    user = SimpleUser.empty();
    value = 0;
    position = 0;
  }

  @override
  String toString() => 'Score(user: $user, value: $value, position: $position)';
}
