import 'package:myecl/advert/class/announcer.dart';
import 'package:myecl/tools/functions.dart';

class Advert {
  late final String id;
  late final String title;
  late final String content;
  late final DateTime date;
  late final Announcer announcer;
  late final List<String> tags;
  
  Advert({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.announcer,
    required this.tags
  });

  Advert.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    content = json["content"];
    date = DateTime.parse(json["date"]);
    announcer = Announcer.fromJson(json["advertiser"]);
    tags = json["tags"].split(', ');
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["content"] = content;
    data["date"] = processDateToAPI(date);
    data["advertiser_id"] = announcer.id;
    data["tags"] = tags.join(', ');
    return data;
  }

  Advert copyWith(
    {id, title, content, date, author, announcer, tags}) {
      return Advert(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        date: date ?? this.date,
        announcer: announcer ?? this.announcer,
        tags: tags ?? this.tags);
    }

  static Advert empty() {
    return Advert(
      id: "",
      title: "",
      content: "",
      date: DateTime.now(),
      announcer: Announcer.empty(),
      tags: []);
  }

  @override
  String toString() {
    return 'Advert{id: $id, title: $title, content: $content, date: $date, announcer: $announcer, tags: $tags}';
  }
}