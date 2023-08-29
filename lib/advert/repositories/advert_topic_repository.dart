import 'package:myecl/tools/repository/repository.dart';

class AdvertTopicRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'notification/';
  final prefix = "advert_";

  Future<bool> subscribeAdvert(String topic) async {
    return await create({}, suffix: "topics/$prefix$topic/subscribe");
  }

  Future<bool> unsubscribeAdvert(String topic) async {
    return await create({}, suffix: "topics/$prefix$topic/unsubscribe");
  }

  Future<List<String>> getAdvertTopics() async {
    return List<String>.from(
        (await getList(suffix: "topics")).map((x) => x.split(prefix)[1]));
  }
}
