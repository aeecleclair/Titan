import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/providers/paiement_page_provider.dart';
import 'package:myecl/paiement/ui/pages/main_page/account_button.dart';

class AccountCard extends HookConsumerWidget {
  const AccountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.read(paiementPageProvider.notifier);
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 9, 103, 103),
              Color(0xff017f80),
              Color.fromARGB(255, 4, 84, 84)
            ]),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
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
                    children: const [
                      Text(
                        'Solde personnel',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      HeroIcon(
                        HeroIcons.chartPie,
                        color: Colors.white,
                        size: 30,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "348,23 €",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AccountButton(
                  icon: HeroIcons.qrCode,
                  title: "Payer",
                  onPressed: () {
                    pageNotifier.setPaiementPage(PaiementPage.pay);
                  },
                ),
                AccountButton(
                  icon: HeroIcons.viewfinderCircle,
                  title: "Scanner",
                  onPressed: () {
                    pageNotifier.setPaiementPage(PaiementPage.scan);
                  },
                ),
                AccountButton(
                  icon: HeroIcons.creditCard,
                  title: "Alimenter",
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
