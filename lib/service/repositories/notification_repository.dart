import 'package:myecl/service/class/message.dart';
import 'package:myecl/service/class/topic.dart';
import 'package:myecl/service/tools/functions.dart';
import 'package:myecl/tools/repository/repository.dart';

class NotificationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'notification/';

  Future<List<Message>> getMessages(String firebaseToken) async {
    return List<Message>.from((await getList(suffix: "messages/$firebaseToken"))
        .map((x) => Message.fromJson(x)));
  }

  Future<bool> registerDevice(String firebaseToken) async {
    return await apply({"firebase_token": firebaseToken}, suffix: "devices");
  }

  Future<bool> forgetDevice(String firebaseToken) async {
    return await delete("devices/$firebaseToken");
  }

  Future<bool> subscribeTopic(Topic topic) async {
    final String topicString = topic.toString().split('.').last;
    return await apply({}, suffix: "topics/$topicString/subscribe");
  }

  Future<bool> unsubscribeTopic(Topic topic) async {
    final String topicString = topic.toString().split('.').last;
    return await apply({}, suffix: "topics/$topicString/unsubscribe");
  }

  Future<List<Topic>> getTopics() async {
    return List<Topic>.from((await getList(suffix: "topics") as List<String>)
        .map((x) => stringToTopic(x)));
  }
}
