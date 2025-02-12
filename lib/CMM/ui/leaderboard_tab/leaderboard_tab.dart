import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/providers/user_score_provider.dart';
import 'package:myecl/CMM/ui/components/sorting_score_bar.dart';
import 'package:myecl/CMM/ui/leaderboard_tab/leaderboard_item.dart';

class LeaderboardTab extends ConsumerWidget {
  const LeaderboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderBoard = ref.watch(userCMMScoreListProvider);
    //final bestUserScore = ref.watch(userCMMScoreProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "LeaderBoard",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SortingScoreBar(),
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
            child: leaderBoard.when(
              data: (scoreList) => ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: scoreList.length,
                itemBuilder: (context, index) {
                  return CMMLeaderBoardItem(score: scoreList[index]);
                },
              ),
              error: (e, s) => Text(e.toString()),
              loading: () => const Text("Loading"),
            ),
          ),
        ),
        // AsyncChild(
        //   value: bestUserScore,
        //   builder: (context, score) => Text("Your score: ${score.value}"),
        //   errorBuilder: (e, s) => Container(),
        // ),
      ],
    );
  }
}
