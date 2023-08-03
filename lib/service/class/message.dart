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

  @override
  String toString() {
    return 'Message{title: $title, content: $content, actionModule: $actionModule, actionTable: $actionTable, context: $context, isVisible: $isVisible}';
  }
}
