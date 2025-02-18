import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/paiement/providers/paiement_page_provider.dart';
import 'package:myecl/paiement/tools/constants.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(paiementPageProvider);
    final pageNotifier = ref.watch(paiementPageProvider.notifier);
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              child: Builder(
                builder: (BuildContext appBarContext) {
                  return IconButton(
                      onPressed: () {
                        switch (page) {
                          case PaiementPage.main:
                            controllerNotifier.toggle();
                            break;
                          case PaiementPage.scan:
                            pageNotifier.setPaiementPage(PaiementPage.main);
                            break;
                          case PaiementPage.pay:
                            pageNotifier.setPaiementPage(PaiementPage.main);
                            break;
                          case PaiementPage.qr:
                            pageNotifier.setPaiementPage(PaiementPage.main);
                            break;
                        }
                      },
                      icon: HeroIcon(
                        page == PaiementPage.main
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: Colors.black,
                        size: 30,
                      ));
                },
              ),
            ),
            const Text(PaiementTextConstants.paiement,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
