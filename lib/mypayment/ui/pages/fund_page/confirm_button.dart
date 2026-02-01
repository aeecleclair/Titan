import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/class/init_info.dart';
import 'package:titan/mypayment/providers/fund_amount_provider.dart';
import 'package:titan/mypayment/providers/funding_url_provider.dart';
import 'package:titan/mypayment/providers/my_history_provider.dart';
import 'package:titan/mypayment/providers/my_wallet_provider.dart';
import 'package:titan/mypayment/providers/tos_provider.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/web-window/web_window.dart' as web;
import 'package:url_launcher/url_launcher.dart';

class ConfirmFundButton extends ConsumerWidget {
  const ConfirmFundButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundAmount = ref.watch(fundAmountProvider);
    final myWalletNotifier = ref.watch(myWalletProvider.notifier);
    final myHistoryNotifier = ref.watch(myHistoryProvider.notifier);
    final fundAmountNotifier = ref.watch(fundAmountProvider.notifier);
    final fundingUrlNotifier = ref.watch(fundingUrlProvider.notifier);
    final myWallet = ref.watch(myWalletProvider);
    final tos = ref.watch(tosProvider);
    final maxBalanceAmount = tos.maybeWhen(
      orElse: () => 0,
      data: (tos) => tos.maxWalletBalance / 100,
    );
    final currentAmount = myWallet.maybeWhen(
      orElse: () => 0,
      data: (wallet) => wallet.balance / 100,
    );

    final redirectUrl = kIsWeb
        ? "${getTitanURL()}static.html" // ?
        : "${getTitanURLScheme()}://mypayment";
    final amountToAdd = double.tryParse(fundAmount.replaceAll(",", ".")) ?? 0;

    final minValidFundAmount =
        fundAmount.isNotEmpty &&
        double.parse(fundAmount.replaceAll(',', '.')) >= 1;
    final maxValidFundAmount = amountToAdd + currentAmount <= maxBalanceAmount;

    void displayToastWithContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    Future<void> tryLaunchUrl(url) async {
      if (!await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch google');
      }
    }

    void helloAssoCallback(String fundingUrl) async {
      dynamic popupWin = web.window().open(
        fundingUrl,
        "HelloAsso",
        "width=800, height=900, scrollbars=yes",
      );

      if (popupWin == null) {
        displayToastWithContext(TypeMsg.error, "Veuillez autoriser les popups");
        return;
      }

      final completer = Completer();
      void checkWindowClosed() {
        if (popupWin.closed == true) {
          completer.complete();
        } else {
          Future.delayed(const Duration(milliseconds: 100), checkWindowClosed);
        }
      }

      checkWindowClosed();
      completer.future.then((_) {});

      void login(String data) async {
        final receivedUri = Uri.parse(data);
        final code = receivedUri.queryParameters["code"];
        if (code == "succeeded") {
          displayToastWithContext(TypeMsg.msg, "Paiement effectué avec succès");
          myWalletNotifier.getMyWallet();
          myHistoryNotifier.getHistory();
        } else {
          displayToastWithContext(TypeMsg.error, "Paiement annulé");
        }
        popupWin.close();
        Navigator.pop(context, code);
      }

      web.window().onMessage.listen((event) {
        if (event.data.toString().contains('code=')) {
          login(event.data.toString());
        }
      });
    }

    return WaitingButton(
      onTap: () async {
        if (!minValidFundAmount) {
          displayToastWithContext(
            TypeMsg.error,
            "Veuillez entrer un montant supérieur à 1€",
          );
          return;
        }
        if (!maxValidFundAmount) {
          displayToastWithContext(
            TypeMsg.error,
            "Le montant maximum de votre portefeuille est de ${maxBalanceAmount.toStringAsFixed(2)}€",
          );
          return;
        }

        final value = await fundingUrlNotifier.getFundingUrl(
          InitInfo(
            amount: (double.parse(fundAmount.replaceAll(',', '.')) * 100)
                .round(),
            redirectUrl: redirectUrl,
          ),
        );
        value.when(
          data: (fundingUrl) {
            fundAmountNotifier.setFundAmount("");
            Navigator.pop(context);
            if (kIsWeb) {
              helloAssoCallback(fundingUrl.url);
              return;
            }
            tryLaunchUrl(fundingUrl.url);
          },
          loading: () {},
          error: (error, _) {
            displayToastWithContext(TypeMsg.error, error.toString());
          },
        );
      },
      waitingColor: const Color(0xff2e2f5e),
      builder: (Widget child) => Container(
        height: 75,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: (minValidFundAmount && maxValidFundAmount)
              ? Colors.white
              : Colors.grey.shade200.withValues(alpha: 0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 5,
              offset: const Offset(1, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: child,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SvgPicture.asset(
              'assets/images/helloasso.svg',
              width: 50,
              height: 50,
            ),
          ),
          Text(
            "Payer avec HelloAsso",
            style: TextStyle(
              color: (minValidFundAmount && maxValidFundAmount)
                  ? const Color(0xff2e2f5e)
                  : const Color(0xff2e2f5e).withValues(alpha: 0.5),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
