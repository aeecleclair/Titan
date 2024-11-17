import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/wallet_device.dart';
import 'package:myecl/paiement/repositories/devices_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class DeviceListNotifier extends ListNotifier<WalletDevice> {
  final DevicesRepository devicesRepository;
  DeviceListNotifier({required this.devicesRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<WalletDevice>>> getDeviceList() async {
    return await loadList(devicesRepository.getDevices);
  }

  Future<bool> revokeDevice(WalletDevice device) async {
    return await update(
        (device) => devicesRepository.revokeDevice(device.id),
        (devices, device) =>
            devices..[devices.indexWhere((d) => d.id == device.id)] = device,
        device);
  }
}

final deviceListProvider =
    StateNotifierProvider<DeviceListNotifier, AsyncValue<List<WalletDevice>>>(
        (ref) {
  final deviceListRepository = ref.watch(devicesRepositoryProvider);
  return DeviceListNotifier(devicesRepository: deviceListRepository)
    ..getDeviceList();
});
