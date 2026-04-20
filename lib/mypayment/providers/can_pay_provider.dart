import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/mypayment/class/wallet_device.dart';
import 'package:titan/mypayment/providers/has_accepted_tos_provider.dart';
import 'package:titan/mypayment/providers/key_service_provider.dart';
import 'package:titan/mypayment/repositories/devices_repository.dart';
import 'package:titan/mypayment/tools/can_pay.dart';
import 'package:titan/tools/exception.dart';

final canPayProvider = FutureProvider.autoDispose<CanPayResult>((ref) async {
  final hasAcceptedToS = ref.watch(hasAcceptedTosProvider);

  if (!hasAcceptedToS) {
    return const CanPayResult.fail(CanPayError.tosNotAccepted);
  }

  final keyService = ref.read(keyServiceProvider);
  final keyId = await keyService.getKeyId();
  if (keyId == null) {
    return const CanPayResult.fail(CanPayError.noDevice);
  }

  final devicesRepository = ref.read(devicesRepositoryProvider);
  try {
    final device = await devicesRepository.getDevice(keyId);
    if (device.status == WalletDeviceStatus.inactive) {
      return const CanPayResult.fail(CanPayError.deviceInactive);
    }
    if (device.status == WalletDeviceStatus.revoked) {
      return const CanPayResult.fail(CanPayError.deviceRevoked);
    }
  } on AppException catch (e) {
    if (e.type == ErrorType.notFound) {
      return const CanPayResult.fail(CanPayError.noDevice);
    }
    return const CanPayResult.fail(CanPayError.noDevice);
  } catch (_) {
    return const CanPayResult.fail(CanPayError.noDevice);
  }

  return const CanPayResult.ok();
});

final canPayWithAmountProvider = FutureProvider.autoDispose
    .family<CanPayResult, int>((ref, amount) async {
  final baseResult = await ref.watch(canPayProvider.future);
  if (!baseResult.success) {
    return baseResult;
  }

  return baseResult;
});
