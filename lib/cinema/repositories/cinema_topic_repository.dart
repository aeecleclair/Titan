import 'package:myecl/tools/repository/repository.dart';

class CinemaTopicRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'notification/';
  final prefix = "cinema_";

  Future<bool> subscribeSession(String topic) async {
    return await apply({}, suffix: "topics/$prefix$topic/subscribe");
  }

  Future<bool> unsubscribeSession(String topic) async {
    return await apply({}, suffix: "topics/$prefix$topic/unsubscribe");
  }

  Future<List<String>> getCinemaTopics() async {
    return (await getList(
                suffix: "topics/${prefix.substring(0, prefix.length - 1)}")
            as List<String>)
        .map((x) => x.split(prefix)[1])
        .toList();
  }
}
