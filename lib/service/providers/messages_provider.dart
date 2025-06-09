import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/service/class/message.dart';
import 'package:myecl/service/providers/firebase_token_provider.dart';
import 'package:myecl/service/repositories/notification_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class MessagesProvider extends ListNotifier<Message> {
  final NotificationRepository notificationRepository;
  String firebaseToken = "";
  MessagesProvider(this.notificationRepository)
    : super(const AsyncValue.loading());

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
      final firebaseToken = ref.watch(firebaseTokenProvider);
      final notificationRepository = ref.watch(notificationRepositoryProvider);
      MessagesProvider notifier = MessagesProvider(notificationRepository);
      firebaseToken.then((value) => notifier.setFirebaseToken(value));
      return notifier;
    });
