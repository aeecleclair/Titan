import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/flap/tools/constants.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                        controllerNotifier.toggle();
                      },
                      icon: const HeroIcon(
                        HeroIcons.bars3BottomLeft,
                        color: Colors.white,
                        size: 30,
                      ));
                },
              ),
            ),
            Text(FlapTextConstants.flap,
                style: GoogleFonts.silkscreen(
                    textStyle: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.white))),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
      ],
    );
  }
}
