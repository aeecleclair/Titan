import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/ui/components/custom_top_bar.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:myecl/CMM/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CMMTemplate extends HookConsumerWidget {
  final Widget child;
  const CMMTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTopBar(
            title: "CMM",
            root: CMMRouter.root,
            rightIcon: QR.currentPath == CMMRouter.root
                ? Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          //leaderBoardNotifier.getLeaderboard();
                          //bestUserScoreNotifier.getLeaderBoardPosition();
                          QR.to(
                            CMMRouter.root + CMMRouter.leaderboard,
                          );
                        },
                        icon: Icon(
                          Icons.add,
                          size: 40,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          //leaderBoardNotifier.getLeaderboard();
                          //bestUserScoreNotifier.getLeaderBoardPosition();
                          QR.to(
                            CMMRouter.root + CMMRouter.leaderboard,
                          );
                        },
                        icon: const HeroIcon(
                          HeroIcons.trophy,
                          size: 40,
                        ),
                      ),
                    ],
                  )
                : null,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
