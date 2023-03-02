import 'package:myecl/tools/functions.dart';

class Advert {
  late final String id;
  late final String title;
  late final String content;
  late final DateTime date;
  late final String author;
  late final List<String> announcer;
  late final List<String> tags;
  
  Advert({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.author,
    required this.announcer,
    required this.tags
  });

  Advert.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    content = json["content"];
    date = DateTime.parse(json["start"]);
    author = json["author"];
    announcer = json["announcer"];
    tags = json["tags"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["content"] = content;
    data["date"] = processDateToAPI(date);
    data["author"] = author;
    data["announcer"] = announcer;
    data["tags"] = tags;
    return data;
  }

  Advert copyWith(
    {id, title, content, date, author, groups, tags}) {
      return Advert(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        date: date ?? this.date,
        author: author ?? this.author,
        announcer: groups ?? this.announcer,
        tags: tags ?? this.tags);
    }

  static Advert empty() {
    return Advert(
      id: "",
      title: "",
      content: "",
      date: DateTime.now(),
      author: "",
      announcer: [],
      tags: []);
  }

  @override
  String toString() {
    return 'Advert{id: $id, title: $title, content: $content, date: $date, author: $author, announcer: $announcer, tags: $tags}';
  }
}