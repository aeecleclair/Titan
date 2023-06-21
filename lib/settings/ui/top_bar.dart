import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/settings/router.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TopBar extends HookConsumerWidget {
  const TopBar({Key? key}) : super(key: key);

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
              child: IconButton(
                  onPressed: QR.back,
                  icon: HeroIcon(
                    QR.currentPath == SettingsRouter.root
                        ? HeroIcons.bars3BottomLeft
                        : HeroIcons.chevronLeft,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    size: 30,
                  )),
            ),
            const Text(SettingsTextConstants.settings,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
