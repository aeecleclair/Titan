import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/mypayment/class/wallet_device.dart';
import 'package:titan/mypayment/providers/device_list_provider.dart';
import 'package:titan/mypayment/providers/device_provider.dart';
import 'package:titan/mypayment/providers/fund_amount_provider.dart';
import 'package:titan/mypayment/providers/has_accepted_tos_provider.dart';
import 'package:titan/mypayment/providers/key_service_provider.dart';
import 'package:titan/mypayment/providers/my_wallet_provider.dart';
import 'package:titan/mypayment/providers/pay_amount_provider.dart';
import 'package:titan/mypayment/router.dart';
import 'package:titan/mypayment/ui/pages/fund_page/fund_page.dart';
import 'package:titan/mypayment/ui/pages/main_page/account_card/device_dialog_box.dart';
import 'package:titan/mypayment/ui/pages/main_page/main_card_button.dart';
import 'package:titan/mypayment/ui/pages/main_page/main_card_template.dart';
import 'package:titan/mypayment/ui/pages/pay_page/pay_page.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
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
    final payAmountNotifier = ref.watch(payAmountProvider.notifier);
    final fundAmountNotifier = ref.watch(fundAmountProvider.notifier);
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
      ).then((_) {
        payAmountNotifier.setPayAmount("");
      });
    }

    void showFundModal() async {
      resetHandledKeys();
      await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        scrollControlDisabledMaxHeightRatio:
            (1 - 80 / MediaQuery.of(context).size.height),
        builder: (context) => const FundPage(),
      ).then((code) {
        fundAmountNotifier.setFundAmount("");
      });
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
        if (!kIsWeb)
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
                  if (context.mounted) {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return DeviceDialogBox(
                          title: 'Appareil non enregistré',
                          descriptions:
                              'Votre appareil n\'est pas encore enregistré. \nPour l\'enregistrer, veuillez vous rendre sur la page des appareils.',
                          buttonText: 'Accéder à la page',
                          onClick: () {
                            QR.to(PaymentRouter.root + PaymentRouter.devices);
                          },
                        );
                      },
                    );
                  }
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
