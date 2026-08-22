class EventQuota {
  final int quota;
  final int usedQuota;

  EventQuota({required this.quota, required this.usedQuota});

  factory EventQuota.fromJson(Map<String, dynamic> json) {
    return EventQuota(
      quota: json["quota"] ?? 0,
      usedQuota: json["used_quota"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["quota"] = quota;
    data["used_quota"] = usedQuota;
    return data;
  }
}
