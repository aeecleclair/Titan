import 'package:titan/tools/functions.dart';

class Feedback {
  final String id;
  final String content;
  final String userId;
  final String userName;
  final DateTime creation;
  final bool isAddressed;

  Feedback({
    required this.id,
    required this.content,
    required this.userId,
    required this.userName,
    required this.creation,
    required this.isAddressed,
  });

  Feedback.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      content = json['content'],
      userId = json['user_id'],
      userName = json['user_name'],
      creation = DateTime.parse(json['creation']),
      isAddressed = json['is_addressed'];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['creation'] = processDateToAPI(creation);
    data['is_addressed'] = isAddressed;
    return data;
  }

  Feedback copyWith({
    String? id,
    String? content,
    String? userId,
    String? userName,
    DateTime? creation,
    bool? isAddressed,
  }) {
    return Feedback(
      id: id ?? this.id,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      creation: creation ?? this.creation,
      isAddressed: isAddressed ?? this.isAddressed,
    );
  }

  Feedback.empty()
    : id = "",
      content = "",
      userId = "",
      userName = "",
      creation = DateTime.now(),
      isAddressed = false;

  @override
  String toString() {
    return 'Feedback(id: $id, content: $content, userId: $userId, userName: $userName, creation date: $creation, isAddressed: $isAddressed)';
  }
}
