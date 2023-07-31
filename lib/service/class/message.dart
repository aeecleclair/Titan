import 'package:myecl/service/class/action.dart';

class Message {
  late final String title;
  late final String content;
  late final Action? action;
  late final String context;
  late final bool isVisible;

  Message({
    required this.title,
    required this.content,
    required this.action,
    required this.context,
    required this.isVisible,
  });

  Message.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    action = json['action'];
    context = json['context'];
    isVisible = json['is_visible'];
  }

  @override
  String toString() {
    return 'Message{title: $title, content: $content, action: $action, context: $context, isVisible: $isVisible}';
  }
}
