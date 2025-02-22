import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/meme_score.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/meme/providers/floor_score_provider.dart';
import 'package:myecl/meme/providers/my_score_provider.dart';
import 'package:myecl/meme/providers/promo_score_provider.dart';
import 'package:myecl/meme/providers/sorting_score_entity_bar_provider.dart';
import 'package:myecl/meme/providers/sorting_score_time_bar_provider.dart';
import 'package:myecl/meme/providers/user_score_provider.dart';
import 'package:myecl/meme/ui/components/sorting_score_entity_bar.dart';
import 'package:myecl/meme/ui/components/sorting_score_time_bar.dart';
import 'package:myecl/meme/ui/leaderboard_tab/leaderboard_floor_item.dart';
import 'package:myecl/meme/ui/leaderboard_tab/leaderboard_promo_item.dart';
import 'package:myecl/meme/ui/leaderboard_tab/leaderboard_user_item.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';

class LeaderboardTab extends ConsumerWidget {
  const LeaderboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSortingScoreEntity =
        ref.watch(selectedSortingScoreEntityProvider);
    final userLeaderBoard = ref.watch(userMemeScoreListProvider);
    final promoLeaderboard = ref.watch(promoMemeScoreListProvider);
    final floorLeaderboard = ref.watch(floorMemeScoreListProvider);

    final userLeaderBoardNotifier =
        ref.watch(userMemeScoreListProvider.notifier);
    final promoLeaderboardNotifier =
        ref.watch(promoMemeScoreListProvider.notifier);
    final floorLeaderboardNotifier =
        ref.watch(floorMemeScoreListProvider.notifier);
    final period = ref.watch(selectedSortingScoreTimeProvider);

    final myScore = ref.watch(myScoreProvider);
    return AsyncChild(
      value: (selectedSortingScoreEntity == Entity.user)
          ? userLeaderBoard
          : selectedSortingScoreEntity == Entity.promo
              ? promoLeaderboard
              : floorLeaderboard,
      builder: (context, scoreList) {
        return Refresher(
          onRefresh: () async {
            userLeaderBoardNotifier.getUserLeaderboard(period);
            promoLeaderboardNotifier.getPromoLeaderboard(period);
            floorLeaderboardNotifier.getFloorLeaderboard(period);
          },
          child: Column(
            children: [
              ExpansionTile(
                title: const Text(MemeTextConstant.filters),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: SortingScoreTimeBar(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: SortingScoreEntityBar(),
                  ),
                ],
              ),
              ...scoreList.map((score) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: selectedSortingScoreEntity == Entity.user
                      ? MemeLeaderBoardUserItem(
                          score: score as MemeScoreUser,
                        )
                      : selectedSortingScoreEntity == Entity.promo
                          ? MemeLeaderBoardPromoItem(
                              score: score as MemeScorePromo,
                            )
                          : MemeLeaderBoardFloorItem(
                              score: score as MemeScoreFloor,
                            ),
                );
              }),
              AsyncChild(
                value: myScore,
                builder: (context, score) {
                  if (score.score == 0) {
                    return Container();
                  }
                  return Text(score.toString());
                },
                errorBuilder: (e, s) => Container(),
              ),
            ],
          ),
        );
      },
    );
  }
}
