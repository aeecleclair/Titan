import 'package:titan/advert/class/announcer.dart';
import 'package:titan/tools/functions.dart';

class Advert {
  late final String id;
  late final String title;
  late final String content;
  late final DateTime date;
  late final Announcer announcer;

  Advert({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.announcer,
  });

  Advert.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    content = json["content"];
    date = processDateFromAPI(json["date"]);
    announcer = Announcer.fromJson(json["advertiser"]);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["content"] = content;
    data["date"] = processDateToAPI(date);
    data["advertiser_id"] = announcer.id;
    return data;
  }

  Advert copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? date,
    Announcer? announcer,
  }) {
    return Advert(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      announcer: announcer ?? this.announcer,
    );
  }

  static Advert empty() {
    return Advert(
      id: "",
      title: "",
      content: "",
      date: DateTime.now(),
      announcer: Announcer.empty(),
    );
  }

  @override
  String toString() {
    return 'Advert{id: $id, title: $title, content: $content, date: $date, announcer: $announcer}';
  }
}
