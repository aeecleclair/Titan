import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/service/class/message.dart';
import 'package:myecl/service/repositories/notification_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class MessagesProvider extends ListNotifier<Message> {
  final NotificationRepository notificationRepository =
      NotificationRepository();
  late final String firebaseToken;
  MessagesProvider({required this.firebaseToken})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Message>>> getMessages() async {
    return await loadList(
        () async => notificationRepository.getMessages(firebaseToken));
  }
}

final logsProvider = StateNotifierProvider.family<MessagesProvider,
    AsyncValue<List<Message>>, String>((ref, firebaseToken) {
  MessagesProvider notifier = MessagesProvider(firebaseToken: firebaseToken);
  return notifier;
});
