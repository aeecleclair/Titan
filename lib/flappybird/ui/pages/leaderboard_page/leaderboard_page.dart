import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/flappybird/providers/score_list_provider.dart';
import 'package:titan/flappybird/providers/user_score_provider.dart';
import 'package:titan/flappybird/ui/flappybird_template.dart';
import 'package:titan/flappybird/ui/pages/leaderboard_page/leaderboard_item.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';

class LeaderBoardPage extends HookConsumerWidget {
  const LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderBoard = ref.watch(scoreListProvider);
    final bestUserScore = ref.watch(userScoreProvider);
    final scrollController = useScrollController();
    return FlappyBirdTemplate(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blue,
              padding: const EdgeInsets.only(top: 90, left: 30, right: 30),
              child: leaderBoard.when(
                data: (scoreList) => ScrollToHideNavbar(
                  controller: scrollController,
                  child: ListView.builder(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: scoreList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            "LeaderBoard",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.silkscreen(
                              textStyle: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }
                      return LeaderBoardItem(score: scoreList[index - 1]);
                    },
                  ),
                ),
                error: (e, s) =>
                    Text(e.toString(), style: GoogleFonts.silkscreen()),
                loading: () => Text("Loading", style: GoogleFonts.silkscreen()),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: bestUserScore.when(
                  data: (score) => LeaderBoardItem(score: score),
                  error: (e, s) =>
                      Text(e.toString(), style: GoogleFonts.silkscreen()),
                  loading: () =>
                      Text("Loading", style: GoogleFonts.silkscreen()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
