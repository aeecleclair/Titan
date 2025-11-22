import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/shotgun/router.dart';
import 'package:titan/shotgun/tools/constants.dart';

class ShotgunTemplate extends StatelessWidget {
  final Widget child;
  const ShotgunTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TopBar(
            title: ShotgunTextConstants.shotgun,
            root: ShotgunRouter.root,
            rightIcon: QR.currentPath == ShotgunRouter.root
                ? IconButton(
                    onPressed: () {
                      QR.to(ShotgunRouter.root);
                    },
                    icon: const HeroIcon(
                      HeroIcons.informationCircle,
                      color: Colors.black,
                      size: 40,
                    ),
                  )
                : null,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
