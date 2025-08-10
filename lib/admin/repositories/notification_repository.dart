import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';

class NotificationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "notification/";

  Future<bool> sendNotification(
    String groupId,
    String title,
    String content,
  ) async {
    return await create({
      "group_id": groupId,
      "title": title,
      "content": content,
    }, suffix: "send");
  }
}

final notificationRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return NotificationRepository()..setToken(token);
});
