import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/paiement/ui/components/paiment_delegate/account_card.dart';
import 'package:titan/paiement/ui/components/paiment_delegate/countdown_timer.dart';
import 'package:titan/tools/providers/locale_notifier.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';

class PaimentDelegateModal extends HookConsumerWidget {
  final String itemTitle;
  final String itemDescription;
  final ImageProvider? itemImage;
  final int itemPrice;
  final DateTime? itemExpirationDate;
  final VoidCallback onConfirm;
  const PaimentDelegateModal({
    super.key,
    required this.itemTitle,
    required this.itemDescription,
    required this.itemImage,
    required this.itemPrice,
    this.itemExpirationDate,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    final priceFormatter = NumberFormat.currency(
      locale: locale.toString(),
      symbol: "€",
      decimalDigits: 2,
    );

    final secondsLeft = itemExpirationDate
        ?.difference(DateTime.now())
        .inSeconds;

    return BottomModalTemplate(
      title: itemTitle,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Item Image and Details Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                ),
              ),
              child: Column(
                children: [
                  if (itemImage != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image(
                        image: itemImage!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Text(
                    itemDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Price Tag
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff017f80),
                          Color.fromARGB(255, 4, 84, 84),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff017f80).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.local_offer,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          priceFormatter.format(itemPrice / 100),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Countdown Timer
            if (secondsLeft != null && secondsLeft > 0) ...[
              const SizedBox(height: 24),
              CountdownTimer(totalSeconds: secondsLeft),
            ],

            const SizedBox(height: 24),

            // Wallet Balance Card
            SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: AccountCard(
                onConfirm: onConfirm,
                itemExpirationDate: itemExpirationDate,
                itemPrice: itemPrice,
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
