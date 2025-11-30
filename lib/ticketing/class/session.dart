class Session {
  late final String id;
  late final String name;
  late final int quota;
  late final int usedQuota;
  late final int userQuota;
  late final bool disabled;

  Session({
    required this.id,
    required this.name,
    required this.quota,
    required this.usedQuota,
    required this.userQuota,
    required this.disabled,
  });

  Session.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    quota = json["quota"];
    usedQuota = json["usedQuota"];
    userQuota = json["userQuota"];
    disabled = json["disabled"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["quota"] = quota;
    data["usedQuota"] = usedQuota;
    data["userQuota"] = userQuota;
    data["disabled"] = disabled;
    return data;
  }

  static Session empty() {
    return Session(
      id: "",
      name: "",
      quota: 0,
      usedQuota: 0,
      userQuota: 0,
      disabled: false,
    );
  }
}
