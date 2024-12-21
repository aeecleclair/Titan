import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/providers/leaderboard_provider.dart';
import 'package:myecl/CMM/providers/user_score_provider.dart';
import 'package:myecl/CMM/ui/leaderboard_tab/leaderboard_item.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class LeaderboardTab extends ConsumerWidget {
  const LeaderboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderBoard = ref.watch(scoreListProvider);
    final bestUserScore = ref.watch(userCMMScoreProvider);
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
            child: leaderBoard.when(
              data: (scoreList) => ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: scoreList.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "LeaderBoard",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return CMMLeaderBoardItem(score: scoreList[index - 1]);
                },
              ),
              error: (e, s) => Text(e.toString()),
              loading: () => const Text("Loading"),
            ),
          ),
        ),
        AsyncChild(
          value: bestUserScore,
          builder: (context, score) => Text("Your score: ${score.value}"),
          errorBuilder: (e, s) => Container(),
        ),
      ],
    );
  }
}
