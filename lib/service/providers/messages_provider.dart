import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/service/providers/firebase_token_provider.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';

class MessagesProvider extends ListNotifier2<Message> {
  final Openapi notificationRepository;
  String firebaseToken = "";
  MessagesProvider({required this.notificationRepository})
      : super(const AsyncValue.loading());

  void setFirebaseToken(String token) {
    firebaseToken = token;
  }

  Future<AsyncValue<List<Message>>> getMessages() async {
    return await loadList(() async => notificationRepository
        .notificationMessagesFirebaseTokenGet(firebaseToken: firebaseToken));
  }

  Future<bool> registerDevice() async {
    return (await notificationRepository.notificationDevicesPost(
            body: BodyRegisterFirebaseDeviceNotificationDevicesPost(
                firebaseToken: firebaseToken)))
        .isSuccessful;
  }

  Future<bool> forgetDevice() async {
    return (await notificationRepository.notificationDevicesFirebaseTokenDelete(
            firebaseToken: firebaseToken))
        .isSuccessful;
  }
}

final messagesProvider =
    StateNotifierProvider<MessagesProvider, AsyncValue<List<Message>>>((ref) {
  final notificationRepository = ref.watch(repositoryProvider);
  final firebaseToken = ref.watch(firebaseTokenProvider);
  MessagesProvider notifier = MessagesProvider(notificationRepository: notificationRepository);
  firebaseToken.then((value) => notifier.setFirebaseToken(value));
  return notifier;
});
