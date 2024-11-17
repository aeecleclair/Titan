import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/flappybird/providers/score_list_provider.dart';
import 'package:myecl/flappybird/providers/user_score_provider.dart';
import 'package:myecl/flappybird/router.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:myecl/drawer/providers/theme_provider.dart';

class FlappyBirdTemplate extends HookConsumerWidget {
  final Widget child;
  const FlappyBirdTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderBoardNotifier = ref.watch(scoreListProvider.notifier);
    final bestUserScoreNotifier = ref.watch(userScoreProvider.notifier);
    final isDarkTheme = ref.watch(themeProvider);
    return Container(
      color: isDarkTheme ? Colors.blue[900] : Colors.blue,
      child: SafeArea(
        child: Column(
          children: [
            TopBar(
              title: "Flappy Bird",
              root: FlappyBirdRouter.root,
              textStyle: GoogleFonts.silkscreen(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              rightIcon: QR.currentPath == FlappyBirdRouter.root
                  ? IconButton(
                      onPressed: () {
                        leaderBoardNotifier.getLeaderboard();
                        bestUserScoreNotifier.getLeaderBoardPosition();
                        QR.to(
                          FlappyBirdRouter.root + FlappyBirdRouter.leaderBoard,
                        );
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
