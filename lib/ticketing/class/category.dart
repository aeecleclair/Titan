class Category {
  late final String id;
  late final String eventId;
  late final String name;
  late final List<String> sessions;
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
    required this.sessions,
    required this.requiredMembership,
    required this.price,
    required this.disabled,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? "";
    eventId = json["event_id"] ?? "";
    name = json["name"] ?? "";
    sessions = json["sessions"] != null
        ? List<String>.from(json["sessions"])
        : [];
    requiredMembership = json["required_membership"] ?? "";
    quota = json["quota"] ?? 0;
    usedQuota = json["used_quota"] ?? 0;
    userQuota = json["user_quota"] ?? 0;
    price = (json["price"] ?? 0).toDouble();
    disabled = json["disabled"] ?? false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["event_id"] = eventId;
    data["name"] = name;
    data["sessions"] = sessions;
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
      sessions: [""],
      requiredMembership: "",
      price: 0.0,
      disabled: false,
    );
  }
}
