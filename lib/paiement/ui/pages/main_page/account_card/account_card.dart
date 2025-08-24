import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/class/wallet_device.dart';
import 'package:titan/paiement/providers/device_list_provider.dart';
import 'package:titan/paiement/providers/device_provider.dart';
import 'package:titan/paiement/providers/fund_amount_provider.dart';
import 'package:titan/paiement/providers/has_accepted_tos_provider.dart';
import 'package:titan/paiement/providers/key_service_provider.dart';
import 'package:titan/paiement/providers/my_wallet_provider.dart';
import 'package:titan/paiement/providers/pay_amount_provider.dart';
import 'package:titan/paiement/router.dart';
import 'package:titan/paiement/ui/pages/fund_page/fund_page.dart';
import 'package:titan/paiement/ui/pages/main_page/account_card/device_dialog_box.dart';
import 'package:titan/paiement/ui/pages/main_page/main_card_button.dart';
import 'package:titan/paiement/ui/pages/main_page/main_card_template.dart';
import 'package:titan/paiement/ui/pages/pay_page/pay_page.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/locale_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';

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
    final locale = ref.watch(localeProvider);
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
    final formatter = NumberFormat.currency(
      locale: locale.toString(),
      symbol: "€",
    );
    final localizeWithContext = AppLocalizations.of(context)!;

    void displayToastWithContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    void showPayModal() {
      showCustomBottomModal(
        context: context,
        // backgroundColor: Colors.transparent,
        // scrollControlDisabledMaxHeightRatio:
        //     (1 - 80 / MediaQuery.of(context).size.height),
        // builder: (context) => const PayPage(),
        modal: PayPage(),
        ref: ref,
        onCloseCallback: () => payAmountNotifier.setPayAmount(""),
      );
    }

    void showFundModal() async {
      resetHandledKeys();
      await showCustomBottomModal(
        context: context,
        modal: FundPage(),
        ref: ref,
        onCloseCallback: () => fundAmountNotifier.setFundAmount(""),

        // backgroundColor: Colors.transparent,
        // scrollControlDisabledMaxHeightRatio:
        //     (1 - 80 / MediaQuery.of(context).size.height),
        // builder: (context) => const FundPage(),
      );
    }

    void showNotRegisteredDeviceDialog() async {
      await showDialog(
        context: context,
        builder: (context) {
          return DeviceDialogBox(
            title: localizeWithContext.paiementDeviceNotRegistered,
            descriptions:
                localizeWithContext.paiementDeviceNotRegisteredDescription,
            buttonText: localizeWithContext.paiementAccessPage,
            onClick: () {
              QR.to(PaymentRouter.root + PaymentRouter.devices);
            },
          );
        },
      );
    }

    return MainCardTemplate(
      colors: const [
        Color.fromARGB(255, 9, 103, 103),
        Color(0xff017f80),
        Color.fromARGB(255, 4, 84, 84),
      ],
      title: localizeWithContext.paiementPersonalBalance,
      toggle: toggle,
      actionButtons: [
        MainCardButton(
          colors: buttonGradient,
          icon: HeroIcons.devicePhoneMobile,
          title: localizeWithContext.paiementDevices,
          onPressed: () async {
            ref.invalidate(deviceListProvider);
            QR.to(PaymentRouter.root + PaymentRouter.devices);
          },
        ),
        if (!kIsWeb)
          MainCardButton(
            colors: buttonGradient,
            icon: HeroIcons.qrCode,
            title: localizeWithContext.paiementPay,
            onPressed: () async {
              await tokenExpireWrapper(ref, () async {
                if (!hasAcceptedToS) {
                  displayToastWithContext(
                    TypeMsg.error,
                    localizeWithContext.paiementPleaseAcceptTOS,
                  );
                  return;
                }
                String? keyId = await keyService.getKeyId();
                if (keyId == null) {
                  showNotRegisteredDeviceDialog();
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
                            title:
                                localizeWithContext.paiementDeviceNotActivated,
                            descriptions: localizeWithContext
                                .paiementDeviceNotActivatedDescription,
                            buttonText: localizeWithContext.paiementAccessPage,
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
                            title: localizeWithContext.paiementDeviceRevoked,
                            descriptions: localizeWithContext
                                .paiementReactivateRevokedDeviceDescription,
                            buttonText: localizeWithContext.paiementAccessPage,
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
                      localizeWithContext.paiementDeviceRecoveryError,
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
          title: localizeWithContext.paiementStats,
          onPressed: () async {
            QR.to(PaymentRouter.root + PaymentRouter.stats);
          },
        ),
        MainCardButton(
          colors: buttonGradient,
          icon: HeroIcons.creditCard,
          title: localizeWithContext.paiementTopUpAction,
          onPressed: () async {
            if (!hasAcceptedToS) {
              displayToastWithContext(
                TypeMsg.error,
                localizeWithContext.paiementPleaseAcceptTOS,
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
          formatter.format(wallet.balance / 100),
          style: const TextStyle(color: Colors.white, fontSize: 50),
        ),
        errorBuilder: (error, stackTrace) => Text(
          localizeWithContext.paiementGetBalanceError,
          style: const TextStyle(color: Colors.white, fontSize: 50),
        ),
      ),
    );
  }
}
