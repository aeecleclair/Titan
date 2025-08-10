class NotificationTopic {
  NotificationTopic({
    required this.id,
    required this.name,
    required this.moduleRoot,
    this.topicIdentifier,
    required this.isUserSubscribed,
  });
  late final String id;
  late final String name;
  late final String moduleRoot;
  late final String? topicIdentifier;
  late final bool isUserSubscribed;

  NotificationTopic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    moduleRoot = json['module_root'];
    topicIdentifier = json['topic_identifier'];
    isUserSubscribed = json['is_user_subscribed'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['module_root'] = moduleRoot;
    data['topic_identifier'] = topicIdentifier;
    data['is_user_subscribed'] = isUserSubscribed;
    return data;
  }

  NotificationTopic copyWith({
    String? id,
    String? name,
    String? moduleRoot,
    String? topicIdentifier,
    bool? isUserSubscribed,
  }) {
    return NotificationTopic(
      id: id ?? this.id,
      name: name ?? this.name,
      moduleRoot: moduleRoot ?? this.moduleRoot,
      topicIdentifier: topicIdentifier ?? this.topicIdentifier,
      isUserSubscribed: isUserSubscribed ?? this.isUserSubscribed,
    );
  }

  NotificationTopic.empty() {
    id = '';
    name = '';
    moduleRoot = '';
    topicIdentifier = null;
    isUserSubscribed = false;
  }

  @override
  String toString() {
    return 'NotificationTopic{id : $id, name : $name, moduleRoot : $moduleRoot, topicIdentifier : $topicIdentifier, isUserSubscribed : $isUserSubscribed}';
  }
}
