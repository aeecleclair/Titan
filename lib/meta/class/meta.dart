import 'package:myecl/advert/class/announcer.dart';
import 'package:myecl/tools/functions.dart';

class Meta {
  late final String id;
  late final String title;
  late final String content;
  late final String advertType;
  late final DateTime date;
  late final DateTime? releaseDate;
  late final DateTime? startDate;
  late final DateTime? endDate;
  late final Announcer announcer;
  late final List<String> tags;

  Meta({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.announcer,
    required this.tags,
    required this.advertType,
    required this.releaseDate,
    required this.startDate,
    required this.endDate,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    content = json["content"];
    advertType = json["advert_type"] ?? "advert";
    releaseDate = processDateFromAPI(json["release_date"]);
    startDate = processDateFromAPI(json["start_date"]);
    endDate = processDateFromAPI(json["end_date"]);
    date = processDateFromAPI(json["date"]);
    announcer = Announcer.fromJson(json["advertiser"]);
    tags = json["tags"].split(', ');
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["content"] = content;
    data["advert_type"] = advertType;
    data["date"] = processDateToAPI(date);
    if (releaseDate != null) {
      data["release_date"] = processDateToAPI(releaseDate!);
    }
    if (startDate != null) {
      data["start_date"] = processDateToAPI(startDate!);
    }
    if (endDate != null) {
      data["end_date"] = processDateToAPI(endDate!);
    }
    data["advertiser_id"] = announcer.id;
    data["tags"] = tags.join(', ');
    return data;
  }

  Meta copyWith({id, title, content, advertType, date, releaseDate, startDate, endDate, author, announcer, tags}) {
    return Meta(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      advertType: advertType ?? this.advertType,
      date: date ?? this.date,
      releaseDate: releaseDate ?? this.releaseDate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      announcer: announcer ?? this.announcer,
      tags: tags ?? this.tags,
    );
  }

  static Meta empty() {
    return Meta(
      id: "",
      title: "",
      content: "",
      advertType: "advert",
      date: DateTime.now(),
      releaseDate: null,
      startDate: null,
      endDate: null,
      announcer: Announcer.empty(),
      tags: [],
    );
  }

  @override
  String toString() {
    return 'Advert{id: $id, title: $title, content: $content, advertType: $advertType, date: $date, releaseDate: $releaseDate, startDate: $startDate, endDate: $endDate, announcer: $announcer, tags: $tags}';
  }
}
