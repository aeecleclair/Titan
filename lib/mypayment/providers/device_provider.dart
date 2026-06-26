import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class DeviceNotifier extends SingleNotifierAPI<WalletDevice> {
  Openapi get devicesRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<WalletDevice> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<WalletDevice>> getDevice(String deviceId) async {
    return await load(
      () => devicesRepository.mypaymentUsersMeWalletDevicesWalletDeviceIdGet(
        walletDeviceId: deviceId,
      ),
    );
  }

  Future<String?> registerDevice(WalletDeviceCreation body) async {
    try {
      final fake = await devicesRepository.mypaymentUsersMeWalletDevicesPost(
        body: body,
      );
      if (fake.body == null) {
        state = AsyncValue.error(
          'Error while creating device',
          StackTrace.current,
        );
        return null;
      }
      state = AsyncValue.data(fake.body!);
      return fake.body!.id;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return null;
    }
  }
}

final deviceProvider =
    NotifierProvider<DeviceNotifier, AsyncValue<WalletDevice>>(
      DeviceNotifier.new,
    );
