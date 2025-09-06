import 'package:titan/tools/functions.dart';

class Advert {
  late final String id;
  late final String title;
  late final String content;
  late final DateTime date;
  late final String associationId;
  late final bool postToFeed;
  late final bool notification;

  Advert({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.associationId,
    required this.postToFeed,
    required this.notification,
  });

  Advert.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    content = json["content"];
    date = processDateFromAPI(json["date"]);
    associationId = json["advertiser_id"];
    postToFeed = json["post_to_feed"] ?? false;
    notification = json["notification"] ?? true;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["content"] = content;
    data["date"] = processDateToAPI(date);
    data["advertiser_id"] = associationId;
    data["post_to_feed"] = postToFeed;
    data["notification"] = notification;
    return data;
  }

  Advert copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? date,
    String? associationId,
    bool? postToFeed,
    bool? notification,
  }) {
    return Advert(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      associationId: associationId ?? this.associationId,
      postToFeed: postToFeed ?? this.postToFeed,
      notification: notification ?? this.notification,
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
      notification: true,
    );
  }

  @override
  String toString() {
    return 'Advert{id: $id, title: $title, content: $content, date: $date, association_id: $associationId, postToFeed: $postToFeed, notification: $notification}';
  }
}
