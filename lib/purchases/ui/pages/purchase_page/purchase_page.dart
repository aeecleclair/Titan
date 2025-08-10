import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/purchases/providers/purchase_provider.dart';
import 'package:titan/purchases/ui/purchases.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/l10n/app_localizations.dart';

class PurchasePage extends HookConsumerWidget {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchase = ref.watch(purchaseProvider);

    return PurchasesTemplate(
      child: Refresher(
        controller: ScrollController(),
        onRefresh: () async {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: AsyncChild(
            value: purchase,
            builder: (context, data) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    data.product.nameFR,
                    style: const TextStyle(fontSize: 40, color: Colors.black),
                  ),
                  ...!data.validated
                      ? [
                          const SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(context)!.purchasesNotPaid,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                            ),
                          ),
                        ]
                      : [],
                  const SizedBox(height: 10),
                  Text(
                    data.product.descriptionFR ?? "",
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
