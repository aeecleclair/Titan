import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/repository/repository.dart';

class DevicesProvider extends StateNotifier<void> {
  final Openapi notificationRepository;
  DevicesProvider({required this.notificationRepository})
      : super(const AsyncValue.loading());

  Future<bool> registerDevice(String firebaseToken) async {
    return (await notificationRepository.notificationDevicesPost(
      body: BodyRegisterFirebaseDeviceNotificationDevicesPost(
        firebaseToken: firebaseToken,
      ),
    ))
        .isSuccessful;
  }

  Future<bool> forgetDevice(String firebaseToken) async {
    return (await notificationRepository.notificationDevicesFirebaseTokenDelete(
      firebaseToken: firebaseToken,
    ))
        .isSuccessful;
  }
}

final devicesProvider = StateNotifierProvider<DevicesProvider, void>((ref) {
  final notificationRepository = ref.watch(repositoryProvider);
  DevicesProvider notifier =
      DevicesProvider(notificationRepository: notificationRepository);
  return notifier;
});
