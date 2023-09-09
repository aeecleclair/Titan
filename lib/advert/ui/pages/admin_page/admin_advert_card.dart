import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/advert/ui/components/advert_card.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';

class AdminAdvertCard extends HookConsumerWidget {
  final VoidCallback onTap, onEdit;
  final Future Function() onDelete;
  final Advert advert;

  const AdminAdvertCard(
      {super.key,
      required this.advert,
      required this.onTap,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        AdvertCard(onTap: onTap, advert: advert),
        Positioned(
          right: 15,
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onEdit,
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey.shade100,
                          Colors.grey.shade400,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(2, 3))
                      ],
                    ),
                    child:
                        const HeroIcon(HeroIcons.pencil, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                WaitingButton(
                  onTap: onDelete,
                  builder: (child) => Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AdvertColorConstants.redGradient1,
                            AdvertColorConstants.redGradient2,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: AdvertColorConstants.redGradient2
                                  .withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(2, 3))
                        ],
                      ),
                      child: child),
                  child: const HeroIcon(HeroIcons.trash, color: Colors.white),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
