import 'package:titan/ticketing/class/announcer.dart';
import 'package:titan/tools/functions.dart';

class Event {
  late final String id;
  late final String title;
  late final String content;
  late final DateTime date;
  late final Announcer announcer;
  late final String ticket;
  late final List<String> form;

  Event({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.announcer,
    required this.ticket,
    required this.form,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    content = json["content"];
    date = processDateFromAPI(json["date"]);
    announcer = Announcer.fromJson(json["advertiser"]);
    ticket = json["ticket"];
    form = json["form"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["content"] = content;
    data["date"] = processDateToAPI(date);
    data["advertiser_id"] = announcer.id;
    data["ticket"] = ticket;
    data["form"];
    return data;
  }

  static Event empty() {
    return Event(
      id: "",
      title: "",
      content: "",
      date: DateTime.now(),
      announcer: Announcer.empty(),
      ticket: "",
      form: [""],
    );
  }
}
