import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/service/class/message.dart';
import 'package:titan/service/providers/firebase_token_provider.dart';
import 'package:titan/service/repositories/notification_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class MessagesProvider extends ListNotifier<Message> {
  final NotificationRepository notificationRepository =
      NotificationRepository();
  String firebaseToken = "";
  MessagesProvider({required String token})
    : super(const AsyncValue.loading()) {
    notificationRepository.setToken(token);
  }

  void setFirebaseToken(String token) {
    firebaseToken = token;
  }

  Future<AsyncValue<List<Message>>> getMessages() async {
    return await loadList(
      () async => notificationRepository.getMessages(firebaseToken),
    );
  }

  Future<bool> registerDevice() async {
    return await notificationRepository.registerDevice(firebaseToken);
  }

  Future<bool> forgetDevice() async {
    return await notificationRepository.forgetDevice(firebaseToken);
  }
}

final messagesProvider =
    StateNotifierProvider<MessagesProvider, AsyncValue<List<Message>>>((ref) {
      final token = ref.watch(tokenProvider);
      final firebaseToken = ref.watch(firebaseTokenProvider);
      MessagesProvider notifier = MessagesProvider(token: token);
      firebaseToken.then((value) => notifier.setFirebaseToken(value));
      return notifier;
    });
