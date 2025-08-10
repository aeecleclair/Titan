import 'package:titan/feed/class/news.dart';

bool isNewsTerminated(News news) {
  final now = DateTime.now();
  if (news.end != null && news.end!.isBefore(now)) {
    return true;
  }
  return false;
}

bool isNewsOngoing(News news) {
  final now = DateTime.now();
  if (news.start.isBefore(now) && (news.end == null || news.end!.isAfter(now))) {
    return true;
  }
  return false;
}


String getNewsSubtitle(News news) {
  String subtitle = '';
  if (news.end != null) {
    subtitle = '${news.start.toLocal().toIso8601String()} - ${news.end!.toLocal().toIso8601String()}';
  }
  if (news.location != null && news.location!.isNotEmpty) {
    subtitle += ' | ${news.location}';
  }
  if (subtitle.isEmpty) {
    subtitle = news.entity;
  }
  return subtitle;
}