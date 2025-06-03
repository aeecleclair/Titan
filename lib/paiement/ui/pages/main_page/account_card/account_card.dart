import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/paiement/class/create_device.dart';
import 'package:myecl/paiement/class/wallet_device.dart';
import 'package:myecl/paiement/providers/device_list_provider.dart';
import 'package:myecl/paiement/providers/device_provider.dart';
import 'package:myecl/paiement/providers/has_accepted_tos_provider.dart';
import 'package:myecl/paiement/providers/key_service_provider.dart';
import 'package:myecl/paiement/providers/my_history_provider.dart';
import 'package:myecl/paiement/providers/my_wallet_provider.dart';
import 'package:myecl/paiement/router.dart';
import 'package:myecl/paiement/tools/platform_info.dart';
import 'package:myecl/paiement/ui/pages/fund_page/fund_page.dart';
import 'package:myecl/paiement/ui/pages/main_page/account_card/device_dialog_box.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_button.dart';
import 'package:myecl/paiement/ui/pages/main_page/main_card_template.dart';
import 'package:myecl/paiement/ui/pages/pay_page/pay_page.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AccountCard extends HookConsumerWidget {
  final Function? toggle;
  final Function resetHandledKeys;
  const AccountCard({
    super.key,
    required this.toggle,
    required this.resetHandledKeys,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myWallet = ref.watch(myWalletProvider);
    final keyService = ref.read(keyServiceProvider);
    final deviceNotifier = ref.watch(deviceProvider.notifier);
    final hasAcceptedToS = ref.watch(hasAcceptedTosProvider);
    final buttonGradient = [
      const Color(0xff017f80),
      const Color.fromARGB(255, 4, 84, 84),
    ];
    final formatter = NumberFormat("#,##0.00", "fr_FR");

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

    void showFundModal() async {
      resetHandledKeys();
      String code = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        scrollControlDisabledMaxHeightRatio:
            (1 - 80 / MediaQuery.of(context).size.height),
        builder: (context) => const FundPage(),
      );
      if (code == "succeeded") {
        displayToastWithContext(TypeMsg.msg, "Paiement effectué avec succès");
        await Future.delayed(Duration(seconds: 5));
        ref.watch(myWalletProvider.notifier).getMyWallet();
        ref.watch(myHistoryProvider.notifier).getHistory();
      } else {
        displayToastWithContext(TypeMsg.error, "Paiement annulé");
      }
    }

    return MainCardTemplate(
      colors: const [
        Color.fromARGB(255, 9, 103, 103),
        Color(0xff017f80),
        Color.fromARGB(255, 4, 84, 84),
      ],
      title: 'Solde personnel',
      toggle: toggle,
      actionButtons: [
        MainCardButton(
          colors: buttonGradient,
          icon: HeroIcons.devicePhoneMobile,
          title: "Appareils",
          onPressed: () async {
            ref.invalidate(deviceListProvider);
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
              if (!hasAcceptedToS) {
                displayToastWithContext(
                  TypeMsg.error,
                  "Veuillez accepter les Conditions Générales d'Utilisation.",
                );
                return;
              }
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
                data: (device) async {
                  if (device.status == WalletDeviceStatus.active) {
                    showPayModal();
                  } else if (device.status == WalletDeviceStatus.inactive) {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return DeviceDialogBox(
                          title: 'Appareil non activé',
                          descriptions:
                              'Votre appareil n\'est pas encore activé. \nPour l\'activer, veuillez vous rendre sur la page des appareils.',
                          buttonText: 'Accéder à la page',
                          onClick: () {
                            QR.to(PaymentRouter.root + PaymentRouter.devices);
                          },
                        );
                      },
                    );
                  } else {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return DeviceDialogBox(
                          title: 'Appareil révoqué',
                          descriptions:
                              'Votre appareil a été révoqué. \nPour le réactiver, veuillez vous rendre sur la page des appareils.',
                          buttonText: 'Accéder à la page',
                          onClick: () {
                            QR.to(PaymentRouter.root + PaymentRouter.devices);
                          },
                        );
                      },
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
            QR.to(PaymentRouter.root + PaymentRouter.stats);
          },
        ),
        MainCardButton(
          colors: buttonGradient,
          icon: HeroIcons.creditCard,
          title: "Recharger",
          onPressed: () async {
            if (!hasAcceptedToS) {
              displayToastWithContext(
                TypeMsg.error,
                "Veuillez accepter les Conditions Générales d'Utilisation.",
              );
              return;
            }
            showFundModal();
          },
        ),
      ],
      child: AsyncChild(
        value: myWallet,
        builder: (context, wallet) => Text(
          '${formatter.format(wallet.balance / 100)} €',
          style: const TextStyle(color: Colors.white, fontSize: 50),
        ),
        errorBuilder: (error, stackTrace) => Text(
          'Erreur lors de la récupération du solde : $error',
          style: const TextStyle(color: Colors.white, fontSize: 50),
        ),
      ),
    );
  }
}
