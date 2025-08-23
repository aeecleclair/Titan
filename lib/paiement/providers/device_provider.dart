import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/class/create_device.dart';
import 'package:titan/paiement/class/wallet_device.dart';
import 'package:titan/paiement/repositories/devices_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class DeviceNotifier extends SingleNotifier<WalletDevice> {
  final DevicesRepository devicesRepository;
  DeviceNotifier({required this.devicesRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<WalletDevice>> getDevice(String deviceId) async {
    return await load(() => devicesRepository.getDevice(deviceId));
  }

  Future<String?> registerDevice(CreateDevice body) async {
    try {
      final fake = await devicesRepository.registerDevice(body);
      state = AsyncValue.data(fake);
      return fake.id;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return null;
    }
  }
}

final deviceProvider =
    StateNotifierProvider<DeviceNotifier, AsyncValue<WalletDevice>>((ref) {
      final deviceListRepository = ref.watch(devicesRepositoryProvider);
      return DeviceNotifier(devicesRepository: deviceListRepository);
    });
