import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class NotificationNotifier extends SingleNotifierAPI<bool> {
  Openapi get notificationRepository => ref.watch(repositoryProvider);
  @override
  AsyncValue<bool> build() {
    return const AsyncValue.loading();
  }

  Future<bool> sendNotification(GroupNotificationRequest mailList) async {
    return (await notificationRepository.notificationSendPost(
      body: mailList,
    )).isSuccessful;
  }
}

final notificationProvider = NotifierProvider<NotificationNotifier, void>(
  () => NotificationNotifier(),
);
