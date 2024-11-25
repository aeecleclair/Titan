class Message {
  late final String? title;
  late final String? content;
  late final String? actionModule;
  late final String? actionTable;

  Message({
    required this.title,
    required this.content,
    required this.actionModule,
    required this.actionTable,
  });

  Message.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    actionModule = json['action_module'];
    actionTable = json['action_table'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['action_module'] = actionModule;
    data['action_table'] = actionTable;
    return data;
  }

  @override
  String toString() {
    return 'Message{title: $title, content: $content, actionModule: $actionModule, actionTable: $actionTable}';
  }
}
