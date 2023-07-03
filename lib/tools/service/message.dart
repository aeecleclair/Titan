class Message {
  late final String title;
  late final String content;
  late final String actionId;
  late final String context;
  late final String firebaseDeviceToken;
  late final bool isVisible;

  Message({
    required this.title,
    required this.content,
    required this.actionId,
    required this.context,
    required this.firebaseDeviceToken,
    required this.isVisible,
  });

  Message.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    actionId = json['actionId'];
    context = json['context'];
    firebaseDeviceToken = json['firebase_device_token'];
    isVisible = json['is_visible'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['actionId'] = actionId;
    data['context'] = context;
    data['firebase_device_token'] = firebaseDeviceToken;
    data['is_visible'] = isVisible;
    return data;
  }

  @override
  String toString() {
    return 'Message{title: $title, content: $content, actionId: $actionId, context: $context, firebaseDeviceToken: $firebaseDeviceToken, isVisible: $isVisible}';
  }
}
