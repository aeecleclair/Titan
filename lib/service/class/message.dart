class Message {
  late final String title;
  late final String content;
  late final String actionId;
  late final String context;
  late final bool isVisible;

  Message({
    required this.title,
    required this.content,
    required this.actionId,
    required this.context,
    required this.isVisible,
  });

  Message.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    actionId = json['action_id'];
    context = json['context'];
    isVisible = json['is_visible'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['actionId'] = actionId;
    data['context'] = context;
    data['is_visible'] = isVisible;
    return data;
  }

  @override
  String toString() {
    return 'Message{title: $title, content: $content, actionId: $actionId, context: $context, isVisible: $isVisible}';
  }
}
