class Message {
  late final String? title;
  late final String? content;
  late final String? actionModule;
  late final String? actionTable;
  late final bool isVisible;
  late final String context;

  Message({
    required this.title,
    required this.content,
    required this.actionModule,
    required this.actionTable,
    required this.context,
    required this.isVisible,
  });

  Message.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    actionModule = json['action_module'];
    actionTable = json['action_table'];
    context = json['context'];
    isVisible = json['is_visible'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['action_module'] = actionModule;
    data['action_table'] = actionTable;
    data['context'] = context;
    data['is_visible'] = isVisible;
    return data;
  }

  @override
  String toString() {
    return 'Message{title: $title, content: $content, actionModule: $actionModule, actionTable: $actionTable, context: $context, isVisible: $isVisible}';
  }
}
