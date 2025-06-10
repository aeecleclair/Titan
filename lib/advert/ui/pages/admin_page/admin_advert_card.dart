import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/advert/class/advert.dart';
import 'package:titan/advert/tools/constants.dart';
import 'package:titan/advert/ui/components/advert_card.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';

class AdminAdvertCard extends HookConsumerWidget {
  final VoidCallback onTap, onEdit;
  final Future Function() onDelete;
  final Advert advert;

  const AdminAdvertCard({
    super.key,
    required this.advert,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Stack(
        children: [
          AdvertCard(onTap: onTap, advert: advert),
          Positioned(
            top: 10,
            right: 15,
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onEdit,
                    child: CardButton(
                      colors: [Colors.grey.shade100, Colors.grey.shade400],
                      shadowColor: Colors.grey.shade300.withValues(alpha: 0.2),
                      child: const HeroIcon(
                        HeroIcons.pencil,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  WaitingButton(
                    onTap: onDelete,
                    builder: (child) => CardButton(
                      colors: const [
                        AdvertColorConstants.redGradient1,
                        AdvertColorConstants.redGradient2,
                      ],
                      shadowColor: AdvertColorConstants.redGradient2.withValues(
                        alpha: 0.2,
                      ),
                      child: child,
                    ),
                    child: const HeroIcon(HeroIcons.trash, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
