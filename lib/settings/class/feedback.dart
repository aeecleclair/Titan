import 'package:titan/tools/functions.dart';

class Feedback {
  final String id;
  final String content;
  final String userId;
  final DateTime creation;

  Feedback({
    required this.id,
    required this.content,
    required this.userId,
    required this.creation,
  });

  Feedback.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      content = json['content'],
      userId = json['user_id'],
      creation = DateTime.parse(json['creation']);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['user_id'] = userId;
    data['creation'] = processDateToAPI(creation);
    return data;
  }

  Feedback copyWith({
    String? id,
    String? content,
    String? userId,
    DateTime? creation,
  }) {
    return Feedback(
      id: id ?? this.id,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      creation: creation ?? this.creation,
    );
  }

  Feedback.empty()
    : id = "",
      content = "",
      userId = "",
      creation = DateTime.now();

  @override
  String toString() {
    return 'Loan(id: $id, content: $content, userId: $userId, creation date: $creation)';
  }
}
