import 'package:myecl/advert/class/announcer.dart';
import 'package:myecl/meta/class/meta.dart';
import 'package:myecl/tools/functions.dart';

class Advert {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final Announcer announcer;
  final List<String> tags;

  Advert({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.announcer,
    required this.tags,
  });

  Advert.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        content = json["content"],
        date = processDateFromAPI(json["date"]),
        announcer = Announcer.fromJson(json["advertiser"]),
        tags = json["tags"].split(', ');

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "date": date.toIso8601String(),
      "tags": tags.join(', '),
      "advertiser_id": announcer.id,
    };
  }

  Advert copyWith({
    dynamic id,
    dynamic title,
    dynamic content,
    dynamic date,
    dynamic announcer,
    dynamic author,
    dynamic tags,
  }) {
    return Advert(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      announcer: announcer is Announcer ? announcer : this.announcer,
      tags: tags is List<String> ? tags : this.tags,
    );
  }

  static Advert empty() {
    return Advert(
      id: "",
      title: "",
      content: "",
      date: DateTime.now(),
      announcer: Announcer.empty(),
      tags: [],
    );
  }

  @override
  String toString() {
    return 'Advert{id: $id, title: $title, content: $content, date: $date, announcer: $announcer, tags: $tags}';
  }
}
