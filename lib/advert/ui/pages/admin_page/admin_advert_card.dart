import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/ui/tools/advert_card.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

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
          right: 40,
          child: SizedBox(
            height: 270,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onEdit,
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(2, 3))
                      ],
                    ),
                    child: const HeroIcon(HeroIcons.pencil, color: Colors.black),
                  ),
                ),
                SizedBox(height: 20,),
                ShrinkButton(
                  onTap: onDelete,
                  waitChild: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(1),
                            blurRadius: 10,
                            offset: const Offset(2, 3))
                      ],
                    ),
                    child: const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    )),
                  ),
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(2, 3))
                      ],
                    ),
                    child: const HeroIcon(HeroIcons.trash, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
