import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/mypayment/providers/my_wallet_provider.dart';
import 'package:titan/tools/ui/styleguide/list_item_template.dart';

const _teal = Color(0xff017f80);

class WalletBalanceCard extends ConsumerWidget {
  const WalletBalanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallet = ref.watch(myWalletProvider);
    final priceFormatter = NumberFormat.currency(
      locale: 'fr_FR',
      symbol: '€',
      decimalDigits: 2,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListItemTemplate(
        title: AppLocalizations.of(context)!.paiementYourBalance,
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _teal.withAlpha(26),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.account_balance_wallet_rounded,
            color: _teal,
            size: 20,
          ),
        ),
        trailing: wallet.when(
          data: (w) => Text(
            priceFormatter.format(w.balance / 100),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _teal,
            ),
          ),
          loading: () => const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          error: (_, _) => const Text(
            '—',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _teal,
            ),
          ),
        ),
      ),
    );
  }
}
