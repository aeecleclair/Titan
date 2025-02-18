import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/class/create_device.dart';
import 'package:myecl/paiement/class/wallet_device.dart';
import 'package:myecl/paiement/providers/device_provider.dart';
import 'package:myecl/paiement/providers/key_service_provider.dart';
import 'package:myecl/paiement/providers/selected_month_provider.dart';
import 'package:myecl/paiement/router.dart';
import 'package:myecl/paiement/tools/platform_info.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_button.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_template.dart';
import 'package:myecl/paiement/ui/pages/pay_page/pay_page.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AccountCard extends HookConsumerWidget {
  final Function? toggle;
  const AccountCard({super.key, required this.toggle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyService = ref.read(keyServiceProvider);
    final deviceNotifier = ref.watch(deviceProvider.notifier);
    final selectedMonthNotifier = ref.watch(selectedMonthProvider.notifier);
    final buttonGradient = [
      const Color(0xff017f80),
      const Color.fromARGB(255, 4, 84, 84),
    ];

    void displayToastWithContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    void showPayModal() {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        scrollControlDisabledMaxHeightRatio:
            (1 - 80 / MediaQuery.of(context).size.height),
        builder: (context) => const PayPage(),
      );
    }

    return MainCardTemplate(
      colors: const [
        Color.fromARGB(255, 9, 103, 103),
        Color(0xff017f80),
        Color.fromARGB(255, 4, 84, 84),
      ],
      title: 'Solde personnel',
      toggle: toggle,
      value: "348,23 €",
      actionButtons: [
        MainCardButton(
          colors: buttonGradient,
          icon: HeroIcons.devicePhoneMobile,
          title: "Appareils",
          onPressed: () async {
            QR.to(PaymentRouter.root + PaymentRouter.devices);
          },
        ),
        // if (!kIsWeb)
        MainCardButton(
          colors: buttonGradient,
          icon: HeroIcons.qrCode,
          title: "Payer",
          onPressed: () async {
            await tokenExpireWrapper(ref, () async {
              String? keyId = await keyService.getKeyId();
              if (keyId == null) {
                final name = await getPlatformInfo();
                final keyPair = await keyService.generateKeyPair();
                final publicKey = (await keyPair.extractPublicKey()).bytes;
                final base64PublicKey = base64Encode(publicKey);
                final body = CreateDevice(
                  name: name,
                  ed25519PublicKey: base64PublicKey,
                );
                final value = await deviceNotifier.registerDevice(body);
                if (value != null) {
                  await keyService.saveKeyPair(keyPair);
                  await keyService.saveKeyId(value);
                }
                keyId = value;
              }
              if (keyId == null) {
                displayToastWithContext(
                  TypeMsg.error,
                  "Erreur lors de la création de l'appareil",
                );
                return;
              }
              final device = await deviceNotifier.getDevice(keyId);
              device.when(
                data: (device) {
                  if (device.status == WalletDeviceStatus.active) {
                    showPayModal();
                  } else if (device.status == WalletDeviceStatus.unactive) {
                    displayToastWithContext(
                      TypeMsg.error,
                      "Votre appareil n'est pas activé",
                    );
                  } else {
                    displayToastWithContext(
                      TypeMsg.error,
                      "Votre appareil a été révoqué",
                    );
                  }
                },
                error: (e, s) {
                  displayToastWithContext(
                    TypeMsg.error,
                    "Erreur lors de la récupération de l'appareil",
                  );
                },
                loading: () {},
              );
            });
          },
        ),
        MainCardButton(
          colors: buttonGradient,
          icon: HeroIcons.chartPie,
          title: "Stats",
          onPressed: () async {
            selectedMonthNotifier.clearSelectedMonth();
            QR.to(PaymentRouter.root + PaymentRouter.stats);
          },
        ),
        MainCardButton(
          colors: buttonGradient,
          icon: HeroIcons.creditCard,
          title: "Alimenter",
          onPressed: () async {},
        ),
      ],
    );
  }
}
