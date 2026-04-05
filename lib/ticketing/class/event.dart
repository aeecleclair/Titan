import 'package:titan/ticketing/class/session.dart';
import 'package:titan/ticketing/class/category.dart';
import 'package:titan/tools/functions.dart';

class Event {
  late final String id;
  late final String name;
  late final DateTime openDate;
  late final DateTime closeDate;
  late final int quota;
  late final int userQuota;
  late final int usedQuota;
  late final bool disabled;
  late final List<Session> sessions;
  late final List<Category> categories;

  Event({
    required this.id,
    required this.name,
    required this.openDate,
    required this.closeDate,
    required this.quota,
    required this.userQuota,
    required this.usedQuota,
    required this.disabled,
    required this.sessions,
    required this.categories,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    openDate = json["open_date"] != null
        ? processDateFromAPI(json["open_date"])
        : DateTime.now();
    closeDate = json["close_date"] != null
        ? processDateFromAPI(json["close_date"])
        : DateTime.now();
    quota = json["quota"];
    userQuota = json["user_quota"];
    usedQuota = json["used_quota"];
    disabled = json["disabled"];
    sessions = json["sessions"] != null
        ? List<Session>.from(json["sessions"].map((x) => Session.fromJson(x)))
        : [];
    categories = json["categories"] != null
        ? List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x)),
          )
        : [];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["open_date"] = processDateToAPI(openDate);
    data["close_date"] = processDateToAPI(closeDate);
    data["quota"] = quota;
    data["user_quota"] = userQuota;
    data["used_quota"] = usedQuota;
    data["disabled"] = disabled;
    data["sessions"] = sessions.map((s) => s.toJson()).toList();
    data["categories"] = categories.map((c) => c.toJson()).toList();
    return data;
  }

  static Event empty() {
    return Event(
      id: "",
      name: "",
      openDate: DateTime.now(),
      closeDate: DateTime.now().add(Duration(days: 1)),
      quota: 0,
      userQuota: 0,
      usedQuota: 0,
      disabled: false,
      sessions: [],
      categories: [],
    );
  }
}
