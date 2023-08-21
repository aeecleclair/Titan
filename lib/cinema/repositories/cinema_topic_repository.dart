import 'package:myecl/tools/repository/repository.dart';

class CinemaTopicRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'notification/';
  final prefix = "cinema_";

  Future<bool> subscribeSession(String topic) async {
    return await create({}, suffix: "topics/$prefix$topic/subscribe");
  }

  Future<bool> unsubscribeSession(String topic) async {
    return await create({}, suffix: "topics/$prefix$topic/unsubscribe");
  }

  Future<List<String>> getCinemaTopics() async {
    return List<String>.from(
        (await getList(suffix: "topics")).map((x) => x.split(prefix)[1]));
  }
}
