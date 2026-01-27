class Question {
  late final String id;
  late final String eventId;
  late final List<String> linkedCategories;
  late final List<String> linkedSessions;
  late final String type;
  late final bool required;
  late final String question;
  late final int quota;
  late final int usedQuota;
  late final double price;
  late final bool disabled;

  Question({
    required this.id,
    required this.eventId,
    required this.linkedCategories,
    required this.linkedSessions,
    required this.type,
    required this.required,
    required this.question,
    required this.price,
    required this.disabled,
  });

  Question.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    eventId = json["event_id"];
    linkedCategories = List<String>.from(json["linked_categories"]);
    linkedSessions = List<String>.from(json["linked_sessions"]);
    type = json["type"];
    required = json["required"];
    question = json["question"];
    quota = json["quota"];
    usedQuota = json["used_quota"];
    price = json["price"].toDouble();
    disabled = json["disabled"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["event_id"] = eventId;
    data["linked_categories"] = linkedCategories;
    data["linked_sessions"] = linkedSessions;
    data["type"] = type;
    data["required"] = required;
    data["question"] = question;
    data["quota"] = quota;
    data["used_quota"] = usedQuota;
    data["price"] = price;
    data["disabled"] = disabled;
    return data;
  }

  static Question empty() {
    return Question(
      id: "",
      eventId: "",
      linkedCategories: [""],
      linkedSessions: [""],
      type: "",
      required: false,
      question: "",
      price: 0.0,
      disabled: false,
    );
  }
}
