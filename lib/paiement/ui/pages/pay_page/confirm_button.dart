import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:titan/event/tools/functions.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/providers/key_service_provider.dart';
import 'package:titan/paiement/providers/my_history_provider.dart';
import 'package:titan/paiement/providers/my_wallet_provider.dart';
import 'package:titan/paiement/providers/pay_amount_provider.dart';
import 'package:titan/paiement/ui/pages/pay_page/info_card.dart';
import 'package:titan/paiement/ui/pages/pay_page/qr_code.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/locale_notifier.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';

class ConfirmButton extends ConsumerWidget {
  const ConfirmButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final keyService = ref.watch(keyServiceProvider);
    final payAmount = ref.watch(payAmountProvider);
    final payAmountNotifier = ref.watch(payAmountProvider.notifier);
    final myHistoryNotifier = ref.read(myHistoryProvider.notifier);
    final myWallet = ref.watch(myWalletProvider);
    final myWalletNotifier = ref.read(myWalletProvider.notifier);
    final LocalAuthentication auth = LocalAuthentication();

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final myWalletBalance = myWallet.maybeWhen(
      orElse: () => 0,
      data: (wallet) => wallet.balance,
    );

    final amount = payAmount.isNotEmpty
        ? double.parse(payAmount.replaceAll(',', '.'))
        : 0.0;

    final enabled = amount > 0 && amount * 100 <= myWalletBalance;

    final formatter = NumberFormat.currency(locale: locale.toString(), symbol: "€");

    void displayQRModal() {
      showModalBottomSheet(
        context: context,
        enableDrag: false,
        scrollControlDisabledMaxHeightRatio:
            (1 - 50 / MediaQuery.of(context).size.height),
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            margin: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(width: 20),
                    InfoCard(
                      icons: HeroIcons.currencyEuro,
                      title: AppLocalizations.of(context)!.paiementAmount,
                      value:
                          formatter.format(double.parse(payAmount.replaceAll(',', '.'))),
                    ),
                    const SizedBox(width: 10),
                    InfoCard(
                      icons: HeroIcons.clock,
                      title: AppLocalizations.of(context)!.paiementValidUntil,
                      value: processDateOnlyHour(
                        DateTime.now().add(const Duration(minutes: 5)),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 20),
                const Padding(padding: EdgeInsets.all(10.0), child: QrCode()),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    child: AddEditButtonLayout(
                      color: Colors.grey.shade200.withValues(alpha: 0.5),
                      child: Text(
                        AppLocalizations.of(context)!.paiementClose,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ).then((_) async {
        await myHistoryNotifier.getHistory();
        await myWalletNotifier.getMyWallet();
        payAmountNotifier.setPayAmount("");
      });
    }

    return GestureDetector(
      onTap: () async {
        if (!enabled) {
          displayToastWithContext(
            TypeMsg.error,
            AppLocalizations.of(context)!.paiementPleaseEnterValidAmount,
          );
          return;
        }
        final authentificationFailedMsg = AppLocalizations.of(
          context,
        )!.paiementAuthentificationFailed;
        final pleaseAddDeviceMsg = AppLocalizations.of(
          context,
        )!.paiementPleaseAddDevice;
        final bool didAuthenticate = await auth.authenticate(
          localizedReason: AppLocalizations.of(
            context,
          )!.paiementPleaseAuthenticate,
          authMessages: [
            AndroidAuthMessages(
              signInTitle: AppLocalizations.of(
                context,
              )!.paiementAuthenticationRequired,
              cancelButton: AppLocalizations.of(context)!.paiementNoThanks,
            ),
            IOSAuthMessages(
              cancelButton: AppLocalizations.of(context)!.paiementNoThanks,
            ),
          ],
        );
        if (!didAuthenticate) {
          displayToastWithContext(TypeMsg.error, authentificationFailedMsg);
          return;
        }
        if ((await keyService.getKeyId()) == null) {
          displayToastWithContext(TypeMsg.error, pleaseAddDeviceMsg);
          return;
        }
        displayQRModal();
      },
      child: Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          color: enabled
              ? Colors.white
              : Colors.grey.shade200.withValues(alpha: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 5,
              offset: const Offset(1, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(25),
        ),
        child: HeroIcon(
          HeroIcons.qrCode,
          color: enabled
              ? const Color(0xff017f80)
              : const Color.fromARGB(134, 1, 128, 128),
          size: 65,
        ),
      ),
    );
  }
}
