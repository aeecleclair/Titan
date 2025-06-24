import 'package:titan/service/class/message.dart';
import 'package:titan/service/class/topic.dart';
import 'package:titan/service/tools/functions.dart';
import 'package:titan/tools/logs/log.dart';
import 'package:titan/tools/repository/repository.dart';

class NotificationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'notification/';

  Future<List<Message>> getMessages(String firebaseToken) async {
    final messages = List<Message>.from(
      (await getList(
        suffix: "messages/$firebaseToken",
      )).map((x) => Message.fromJson(x)),
    );
    for (final message in messages) {
      Repository.logger.writeLog(
        Log(
          message: "Received notification messages ${message.toString()}",
          level: LogLevel.info,
        ),
      );
    }

    return messages;
  }

  Future<bool> registerDevice(String firebaseToken) async {
    return await create({"firebase_token": firebaseToken}, suffix: "devices");
  }

  Future<bool> forgetDevice(String firebaseToken) async {
    return await delete("devices/$firebaseToken");
  }

  Future<bool> subscribeTopic(Topic topic) async {
    final String topicString = topic.toString().split('.').last;
    return await create({}, suffix: "topics/$topicString/subscribe");
  }

  Future<bool> unsubscribeTopic(Topic topic) async {
    final String topicString = topic.toString().split('.').last;
    return await create({}, suffix: "topics/$topicString/unsubscribe");
  }

  Future<List<Topic>> getTopics() async {
    return List<Topic>.from(
      (await getList(suffix: "topics")).map((x) => stringToTopic(x)),
    );
  }
}
