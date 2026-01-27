class Category {
  late final String id;
  late final String eventId;
  late final String name;
  late final List<String> linkedSessions;
  late final String requiredMembership;
  late final int quota;
  late final int usedQuota;
  late final int userQuota;
  late final double price;
  late final bool disabled;

  Category({
    required this.id,
    required this.eventId,
    required this.name,
    required this.linkedSessions,
    required this.requiredMembership,
    required this.price,
    required this.disabled,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    eventId = json["event_id"];
    name = json["name"];
    linkedSessions = List<String>.from(json["linked_sessions"]);
    requiredMembership = json["required_membership"];
    quota = json["quota"];
    usedQuota = json["used_quota"];
    userQuota = json["user_quota"];
    price = json["price"].toDouble();
    disabled = json["disabled"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["event_id"] = eventId;
    data["name"] = name;
    data["linked_sessions"] = linkedSessions;
    data["required_membership"] = requiredMembership;
    data["quota"] = quota;
    data["used_quota"] = usedQuota;
    data["user_quota"] = userQuota;
    data["price"] = price;
    data["disabled"] = disabled;
    return data;
  }

  static Category empty() {
    return Category(
      id: "",
      eventId: "",
      name: "",
      linkedSessions: [""],
      requiredMembership: "",
      price: 0.0,
      disabled: false,
    );
  }
}
