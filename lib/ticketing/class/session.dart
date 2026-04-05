class Session {
  late final String id;
  late final String eventId;
  late final String name;
  late final int quota;
  late final int usedQuota;
  late final int userQuota;
  late final bool disabled;

  Session({
    required this.id,
    required this.eventId,
    required this.name,
    required this.quota,
    required this.usedQuota,
    required this.userQuota,
    required this.disabled,
  });

  Session.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    eventId = json["event_id"];
    name = json["name"];
    quota = json["quota"];
    usedQuota = json["used_quota"];
    userQuota = json["user_quota"];
    disabled = json["disabled"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["event_id"] = eventId;
    data["name"] = name;
    data["quota"] = quota;
    data["used_quota"] = usedQuota;
    data["user_quota"] = userQuota;
    data["disabled"] = disabled;
    return data;
  }

  static Session empty() {
    return Session(
      id: "",
      eventId: "",
      name: "",
      quota: 0,
      usedQuota: 0,
      userQuota: 0,
      disabled: false,
    );
  }
}
