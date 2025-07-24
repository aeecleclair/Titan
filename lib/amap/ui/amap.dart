import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/amap/router.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class AmapTemplate extends StatelessWidget {
  final Widget child;
  const AmapTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.background,
      child: Column(
        children: [
          TopBar(
            root: AmapRouter.root,
            rightIcon: QR.currentPath == AmapRouter.root
                ? IconButton(
                    onPressed: () {
                      QR.to(AmapRouter.root + AmapRouter.presentation);
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
