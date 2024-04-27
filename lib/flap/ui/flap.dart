import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/flap/router.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';

class FlapTemplate extends HookConsumerWidget {
  final Widget child;
  const FlapTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Column(
          children: [
            TopBar(
              title: "Flappy Bird",
              root: FlapRouter.root,
              textStyle: GoogleFonts.silkscreen(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              rightIcon: QR.currentPath == FlapRouter.root
                  ? IconButton(
                      onPressed: () {
                        QR.to(FlapRouter.root + FlapRouter.leaderBoard);
                      },
                      icon: const HeroIcon(
                        HeroIcons.trophy,
                        color: Colors.white,
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
