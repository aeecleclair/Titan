class Message {
  late final String? title;
  late final String? content;
  late final String? actionModule;
  late final String? actionTable;
  late final bool isVisible;
  late final String context;
  late final DateTime? deliveryDateTime;

  Message({
    required this.title,
    required this.content,
    required this.actionModule,
    required this.actionTable,
    required this.context,
    required this.isVisible,
    this.deliveryDateTime,
  });

  Message.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String;
    content = json['content'] as String;
    actionModule = json['action_module'] as String;
    actionTable = json['action_table'] as String;
    context = json['context'] as String;
    isVisible = json['is_visible'] as bool;
    deliveryDateTime = json['delivery_datetime'] != null
        ? DateTime.parse(json['delivery_datetime'] as String)
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['action_module'] = actionModule;
    data['action_table'] = actionTable;
    data['context'] = context;
    data['is_visible'] = isVisible;
    data['delivery_datetime'] =
        deliveryDateTime?.toIso8601String().split('T')[0];
    return data;
  }

  @override
  String toString() {
    return 'Message{title: $title, content: $content, actionModule: $actionModule, actionTable: $actionTable, context: $context, isVisible: $isVisible}';
  }
}
