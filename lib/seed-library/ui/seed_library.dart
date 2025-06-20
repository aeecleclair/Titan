import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/seed-library/router.dart';
import 'package:myecl/seed-library/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SeedLibraryTemplate extends StatelessWidget {
  final Widget child;
  const SeedLibraryTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TopBar(
            title: SeedLibraryTextConstants.seedLibrary,
            root: SeedLibraryRouter.root,
            rightIcon: Uri.parse(QR.currentPath).path == SeedLibraryRouter.root
                ? IconButton(
                    onPressed: () {
                      QR.to(
                        SeedLibraryRouter.root + SeedLibraryRouter.information,
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
    );
  }
}
