import 'package:titan/tools/functions.dart';

class Advert {
  late final String id;
  late final String title;
  late final String content;
  late final DateTime date;
  late final String associationId;
  late final bool postToFeed;

  Advert({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.associationId,
    required this.postToFeed,
  });

  Advert.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    content = json["content"];
    date = processDateFromAPI(json["date"]);
    associationId = json["advertiser_id"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["content"] = content;
    data["date"] = processDateToAPI(date);
    data["advertiser_id"] = associationId;
    data["post_to_feed"] = postToFeed;
    return data;
  }

  Advert copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? date,
    String? associationId,
    bool? postToFeed,
  }) {
    return Advert(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      associationId: associationId ?? this.associationId,
      postToFeed: postToFeed ?? this.postToFeed,
    );
  }

  static Advert empty() {
    return Advert(
      id: "",
      title: "",
      content: "",
      date: DateTime.now(),
      associationId: "",
      postToFeed: false,
    );
  }

  @override
  String toString() {
    return 'Advert{id: $id, title: $title, content: $content, date: $date, association_id: $associationId}';
  }
}
