import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/mypayment/class/wallet_device.dart';
import 'package:titan/mypayment/providers/has_accepted_tos_provider.dart';
import 'package:titan/mypayment/providers/key_service_provider.dart';
import 'package:titan/mypayment/providers/my_wallet_provider.dart';
import 'package:titan/mypayment/repositories/devices_repository.dart';
import 'package:titan/mypayment/router.dart';
import 'package:titan/mypayment/ui/pages/main_page/account_card/device_dialog_box.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/functions.dart';
import 'package:qlevar_router/qlevar_router.dart';

enum CanPayError {
  tosNotAccepted,
  noDevice,
  deviceInactive,
  deviceRevoked,
  insufficientBalance,
}

class CanPayResult {
  final bool success;
  final CanPayError? error;
  const CanPayResult.ok() : success = true, error = null;
  const CanPayResult.fail(this.error) : success = false;
}

Future<CanPayResult> canPay({required WidgetRef ref, int? amount}) async {
  final hasAcceptedToS = ref.read(hasAcceptedTosProvider);
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

  if (amount != null) {
    final wallet = ref.read(myWalletProvider);
    final balanceCheck = wallet.whenOrNull(
      data: (w) {
        if (w.balance < amount) {
          return const CanPayResult.fail(CanPayError.insufficientBalance);
        }
        return null;
      },
    );
    if (balanceCheck != null) return balanceCheck;
  }

  return const CanPayResult.ok();
}

void showCanPayError({
  required BuildContext context,
  required CanPayError error,
}) {
  final l = AppLocalizations.of(context)!;

  switch (error) {
    case CanPayError.tosNotAccepted:
      displayToast(context, TypeMsg.error, l.paiementPleaseAcceptTOS);
    case CanPayError.noDevice:
      _showDeviceDialog(
        context: context,
        title: l.paiementDeviceNotRegistered,
        description: l.paiementDeviceNotRegisteredDescription,
      );
    case CanPayError.deviceInactive:
      _showDeviceDialog(
        context: context,
        title: l.paiementDeviceNotActivated,
        description: l.paiementDeviceNotActivatedDescription,
      );
    case CanPayError.deviceRevoked:
      _showDeviceDialog(
        context: context,
        title: l.paiementDeviceRevoked,
        description: l.paiementReactivateRevokedDeviceDescription,
      );
    case CanPayError.insufficientBalance:
      displayToast(context, TypeMsg.error, l.paiementInsufficientBalance);
  }
}

void _showDeviceDialog({
  required BuildContext context,
  required String title,
  required String description,
}) {
  showDialog(
    context: context,
    builder: (context) => DeviceDialogBox(
      title: title,
      descriptions: description,
      buttonText: AppLocalizations.of(context)!.paiementAccessPage,
      onClick: () {
        QR.to(PaymentRouter.root + PaymentRouter.devices);
      },
    ),
  );
}
