import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class DeviceListNotifier extends ListNotifierAPI<WalletDevice> {
  Openapi get devicesRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<WalletDevice>> build() {
    getDeviceList();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<WalletDevice>>> getDeviceList() async {
    return await loadList(devicesRepository.mypaymentUsersMeWalletDevicesGet);
  }

  Future<bool> revokeDevice(WalletDevice device) async {
    return await update(
      () => devicesRepository
          .mypaymentUsersMeWalletDevicesWalletDeviceIdRevokePost(
            walletDeviceId: device.id,
          ),
      (device) => device.id,
      device,
    );
  }
}

final deviceListProvider =
    NotifierProvider<DeviceListNotifier, AsyncValue<List<WalletDevice>>>(
      DeviceListNotifier.new,
    );
