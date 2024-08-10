import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/purchases/providers/purchase_provider.dart';
import 'package:myecl/purchases/tools/constants.dart';
import 'package:myecl/purchases/ui/purchases.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class PurchasePage extends HookConsumerWidget {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchase = ref.watch(purchaseProvider);

    return PurchasesTemplate(
      child: Refresher(
        onRefresh: () async {},
        child: AsyncChild(
          value: purchase,
          builder: (context, data) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  data.name,
                  style: const TextStyle(fontSize: 40, color: Colors.black),
                ),
                ...!data.validated
                    ? [
                        const SizedBox(height: 10),
                        const Text(
                          PurchasesTextConstants.notPaid,
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ]
                    : [],
                const SizedBox(height: 10),
                Text(
                  data.description,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
