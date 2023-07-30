import 'package:myecl/tools/functions.dart';

class Session {
  late final String id;
  late final String name;
  late final DateTime start;
  late final int duration;
  late final String? overview;
  late final String? genre;
  late final String? tagline;

  Session(
      {required this.id,
      required this.name,
      required this.start,
      required this.duration,
      required this.overview,
      required this.genre,
      required this.tagline});

  Session.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    start = DateTime.parse(json["start"]);
    duration = json["duration"];
    overview = json["overview"];
    genre = json["genre"];
    tagline = json["tagline"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["start"] = processDateToAPI(start);
    data["duration"] = duration;
    data["overview"] = overview;
    data["genre"] = genre;
    data["tagline"] = tagline;
    return data;
  }

  Session copyWith({id, name, start, duration, overview, genre, tagline}) {
    return Session(
        id: id ?? this.id,
        name: name ?? this.name,
        start: start ?? this.start,
        duration: duration ?? this.duration,
        overview: overview ?? this.overview,
        genre: genre ?? this.genre,
        tagline: tagline ?? this.tagline);
  }

  static Session empty() {
    return Session(
        id: "",
        name: "",
        start: DateTime.now(),
        duration: 0,
        overview: "",
        genre: "",
        tagline: "");
  }

  @override
  String toString() {
    return 'Session{id: $id, name: $name, start: $start, duration: $duration, overview: $overview, genre: $genre, tagline: $tagline}';
  }
}
