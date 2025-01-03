import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/amap/router.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AmapTemplate extends StatelessWidget {
  final Widget child;
  const AmapTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TopBar(
            title: AMAPTextConstants.amap,
            root: AmapRouter.root,
            rightIcon: QR.currentPath == AmapRouter.root
                ? IconButton(
                    onPressed: () {
                      QR.to(AmapRouter.root + AmapRouter.presentation);
                    },
                    icon: HeroIcon(
                      HeroIcons.informationCircle,
                      color: Theme.of(context).colorScheme.onPrimary,
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
