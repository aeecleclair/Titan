import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/greenhouse/router.dart';
import 'package:myecl/greenhouse/tools/constants.dart';

class GreenHouseTemplate extends StatelessWidget {
  final Widget child;
  const GreenHouseTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TopBar(
            title: GreenHouseTextConstants.greenhouse,
            root: GreenHouseRouter.root,
            rightIcon: QR.currentPath == GreenHouseRouter.root
                ? IconButton(
                    onPressed: () {
                      QR.to(GreenHouseRouter.root);
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
