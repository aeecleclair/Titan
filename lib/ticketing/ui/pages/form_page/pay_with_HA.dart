import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/event/providers/event_provider.dart';
import 'package:titan/mypayment/class/init_info.dart' show InitInfo;
import 'package:titan/mypayment/providers/fund_amount_provider.dart';
import 'package:titan/mypayment/providers/funding_url_provider.dart';
import 'package:titan/mypayment/providers/my_history_provider.dart';
import 'package:titan/mypayment/providers/my_wallet_provider.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

class ConfirmTicketButton extends ConsumerWidget {
  const ConfirmTicketButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(eventProvider);
    final eventNotifier = ref.watch(eventProvider.notifier);
    final fundAmount = ref.watch(fundAmountProvider);
    final myWalletNotifier = ref.watch(myWalletProvider.notifier);
    final myHistoryNotifier = ref.watch(myHistoryProvider.notifier);
    final fundAmountNotifier = ref.watch(fundAmountProvider.notifier);
    final fundingUrlNotifier = ref.watch(fundingUrlProvider.notifier);
    final redirectUrl = kIsWeb
        ? "${getTitanURL()}static.html" // ?
        : "${getTitanURLScheme()}://mypayment";

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
      html.WindowBase? popupWin =
          html.window.open(
                fundingUrl,
                "HelloAsso",
                "width=800, height=900, scrollbars=yes",
              )
              as html.WindowBase?;

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

      html.window.onMessage.listen((event) {
        if (event.data.toString().contains('code=')) {
          login(event.data);
        }
      });
    }

    return WaitingButton(
      onTap: () async {
        print("Payyyyy");

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
          color: Colors.white,
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
              color: const Color(0xff2e2f5e),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
