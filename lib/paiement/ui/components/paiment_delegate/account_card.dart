import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/providers/my_wallet_provider.dart';
import 'package:titan/paiement/ui/components/paiment_delegate/add_funds_button.dart';
import 'package:titan/paiement/ui/components/paiment_delegate/confirm_button.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/providers/locale_notifier.dart';
import 'package:titan/tools/ui/builders/async_child.dart';

class AccountCard extends HookConsumerWidget {
  final void Function() onConfirm;
  final DateTime? itemExpirationDate;
  final int itemPrice;

  const AccountCard({
    super.key,
    required this.onConfirm,
    required this.itemExpirationDate,
    required this.itemPrice,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final myWallet = ref.watch(myWalletProvider);
    final formatter = NumberFormat.currency(
      locale: locale.toString(),
      symbol: "€",
    );
    final localizeWithContext = AppLocalizations.of(context)!;

    // Check if user has sufficient funds
    final hasSufficientFunds = myWallet.maybeWhen(
      data: (wallet) => wallet.balance >= itemPrice,
      orElse: () => false,
    );

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const [
            Color.fromARGB(255, 9, 103, 103),
            Color(0xff017f80),
            Color.fromARGB(255, 4, 84, 84),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  Row(
                    children: [
                      Text(
                        localizeWithContext.paiementPersonalBalance,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: AsyncChild(
                        value: myWallet,
                        builder: (context, wallet) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              formatter.format(wallet.balance / 100),
                              style: TextStyle(
                                color: hasSufficientFunds
                                    ? ColorConstants.background
                                    : ColorConstants.error,
                                fontSize: 50,
                              ),
                            ),
                          ],
                        ),
                        errorBuilder: (error, stackTrace) => Text(
                          localizeWithContext.paiementGetBalanceError,
                          style: const TextStyle(
                            color: ColorConstants.error,
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: ColorConstants.background,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: hasSufficientFunds
                ? ConfirmButton(
                    onConfirm: onConfirm,
                    itemExpirationDate: itemExpirationDate,
                  )
                : const AddFundsButton(),
          ),
        ],
      ),
    );
  }
}
