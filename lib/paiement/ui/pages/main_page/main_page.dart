import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/ui/pages/main_page/account_card.dart';
import 'package:myecl/paiement/ui/pages/main_page/last_transactions.dart';
import 'package:myecl/paiement/ui/paiement.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class PaymentMainPage extends HookConsumerWidget {
  const PaymentMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaymentTemplate(
      child: Refresher(
          onRefresh: () async {},
          child: Column(
            children: [
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                    controller: PageController(viewportFraction: 0.8),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return const AccountCard();
                    }),
              ),
              const SizedBox(
                height: 25,
              ),
              const LastTransactions()
            ],
          )),
    );
  }
}
