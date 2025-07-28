import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/seed-library/router.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class SeedLibraryTemplate extends StatelessWidget {
  final Widget child;
  const SeedLibraryTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.background,
      child: SafeArea(
        child: Column(
          children: [
            TopBar(
              root: SeedLibraryRouter.root,
              rightIcon: QR.currentPath == SeedLibraryRouter.root
                  ? IconButton(
                      onPressed: () {
                        QR.to(
                          SeedLibraryRouter.root +
                              SeedLibraryRouter.information,
                        );
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
      ),
    );
  }
}
