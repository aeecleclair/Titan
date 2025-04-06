import 'package:myecl/advert/class/announcer.dart';
import 'package:myecl/meta/class/meta.dart';
import 'package:myecl/tools/functions.dart';

class Advert extends Meta {
  Advert({
    required super.id,
    required super.title,
    required super.content,
    required super.date,
    required super.announcer,
    required super.tags,
  });

  Advert.fromJson(Map<String, dynamic> json)
      : super(
          id: json["id"],
          title: json["title"],
          content: json["content"],
          date: processDateFromAPI(json["date"]),
          announcer: Announcer.fromJson(json["advertiser"]),
          tags: json["tags"].split(', '),
        );

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data["advertiser_id"] = announcer.id;
    return data;
  }

  @override
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
