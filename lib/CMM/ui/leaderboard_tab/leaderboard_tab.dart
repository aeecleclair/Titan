import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm_score.dart';
import 'package:myecl/CMM/class/utils.dart';
import 'package:myecl/CMM/providers/floor_score_provider.dart';
import 'package:myecl/CMM/providers/promo_score_provider.dart';
import 'package:myecl/CMM/providers/sorting_score_entity_bar_provider.dart';
import 'package:myecl/CMM/providers/user_score_provider.dart';
import 'package:myecl/CMM/ui/components/sorting_score_time_bar.dart';
import 'package:myecl/CMM/ui/leaderboard_tab/leaderboard_floor_item.dart';
import 'package:myecl/CMM/ui/leaderboard_tab/leaderboard_promo_item.dart';
import 'package:myecl/CMM/ui/leaderboard_tab/leaderboard_user_item.dart';

import '../components/sorting_score_entity_bar.dart';

class LeaderboardTab extends ConsumerWidget {
  const LeaderboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSortingScoreEntity =
        ref.watch(selectedSortingScoreEntityProvider);
    final userLeaderBoard = ref.watch(userCMMScoreListProvider);
    final promoLeaderboard = ref.watch(promoCMMScoreListProvider);
    final floorLeaderboard = ref.watch(floorCMMScoreListProvider);

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
        SortingScoreTimeBar(),
        SizedBox(
          height: 10,
        ),
        SortingScoreEntityBar(),
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
            child: (selectedSortingScoreEntity == Entity.user
                    ? userLeaderBoard
                    : selectedSortingScoreEntity == Entity.promo
                        ? promoLeaderboard
                        : floorLeaderboard)
                .when(
              data: (scoreList) => ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: scoreList.length,
                itemBuilder: (context, index) {
                  print("oui");
                  return selectedSortingScoreEntity == Entity.user
                      ? CMMLeaderBoardUserItem(
                          score: scoreList[index] as CMMScoreUser,
                        )
                      : selectedSortingScoreEntity == Entity.promo
                          ? CMMLeaderBoardPromoItem(
                              score: scoreList[index] as CMMScorePromo,
                            )
                          : CMMLeaderBoardFloorItem(
                              score: scoreList[index] as CMMScoreFloor,
                            );
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
