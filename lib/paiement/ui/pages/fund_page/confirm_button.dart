import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/class/transfert.dart';
import 'package:myecl/paiement/providers/fund_amount_provider.dart';
import 'package:myecl/paiement/providers/funding_url_provider.dart';
import 'package:myecl/paiement/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:universal_html/html.dart' as html;

class ConfirmFundButton extends ConsumerWidget {
  const ConfirmFundButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundAmount = ref.watch(fundAmountProvider);
    final fundingUrlNotifier = ref.watch(fundingUrlProvider.notifier);

    final enabled = fundAmount.isNotEmpty &&
        double.parse(fundAmount.replaceAll(',', '.')) > 0;

    void displayToastWithContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    void helloAssoCallback(String fundingUrl) async {
      html.WindowBase popupWin = html.window.open(
        fundingUrl,
        "HelloAsso",
        "width=800, height=900, scrollbars=yes",
      );

      final completer = Completer();
      void checkWindowClosed() {
        if (popupWin.closed == true) {
          completer.complete();
        } else {
          Future.delayed(
            const Duration(milliseconds: 100),
            checkWindowClosed,
          );
        }
      }

      checkWindowClosed();
      completer.future.then((_) {});

      void login(String data) async {
        final receivedUri = Uri.parse(data);
        final token = receivedUri.queryParameters["code"];
        popupWin.close();
        try {} on TimeoutException catch (_) {
          throw Exception('No response from server');
        } catch (e) {
          rethrow;
        }
      }

      html.window.onMessage.listen((event) {
        print(event.data.toString());
        // if (event.data.toString().contains('code=')) {
        //   login(event.data);
        // }
      });
    }

    return WaitingButton(
      onTap: () async {
        if (!enabled) {
          displayToastWithContext(TypeMsg.error, "Veuillez entrer un montant");
          return;
        }
        final value = await fundingUrlNotifier.getFundingUrl(
          Transfer(
            amount:
                (double.parse(fundAmount.replaceAll(',', '.')) * 100).toInt(),
            type: TransferType.helloAsso,
          ),
        );
        value.when(
          data: (fundingUrl) {
            helloAssoCallback(fundingUrl.url);
          },
          loading: () {},
          error: (error, _) {
            displayToastWithContext(TypeMsg.error, error.toString());
          },
        );
      },
      builder: (Widget child) => Container(
        height: 75,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: enabled
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
              color: enabled
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
