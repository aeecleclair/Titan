import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.enums.swagger.dart';
import 'package:titan/mypayment/providers/has_accepted_tos_provider.dart';
import 'package:titan/mypayment/providers/key_service_provider.dart';
import 'package:titan/mypayment/tools/can_pay.dart';
import 'package:titan/tools/repository/repository.dart';

/// Whether the wallet is in a state that allows paying: terms accepted, a
/// device registered on this install, and that device still active.
///
/// The balance is deliberately left out — it depends on the amount, so callers
/// compare it against their own price.
final canPayProvider = FutureProvider.autoDispose<CanPayResult>((ref) async {
  final hasAcceptedToS = ref.watch(hasAcceptedTosProvider);
  if (!hasAcceptedToS) {
    return const CanPayResult.fail(CanPayError.tosNotAccepted);
  }

  final keyId = await ref.read(keyServiceProvider).getKeyId();
  if (keyId == null) {
    return const CanPayResult.fail(CanPayError.noDevice);
  }

  final response = await ref
      .read(repositoryProvider)
      .mypaymentUsersMeWalletDevicesWalletDeviceIdGet(walletDeviceId: keyId);
  final device = response.body;
  // A device the backend does not know about is the same situation as never
  // having registered one.
  if (!response.isSuccessful || device == null) {
    return const CanPayResult.fail(CanPayError.noDevice);
  }
  switch (device.status) {
    case WalletDeviceStatus.inactive:
      return const CanPayResult.fail(CanPayError.deviceInactive);
    case WalletDeviceStatus.revoked:
      return const CanPayResult.fail(CanPayError.deviceRevoked);
    case WalletDeviceStatus.active:
    case WalletDeviceStatus.swaggerGeneratedUnknown:
      return const CanPayResult.ok();
  }
});
