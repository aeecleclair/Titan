import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/providers/player_histo_provider.dart';
import 'package:myecl/elocaps/tools/constants.dart';
import 'package:myecl/elocaps/ui/elocaps.dart';
import 'package:myecl/elocaps/ui/pages/history_page/game_card.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/user/providers/user_provider.dart';

class HistoryPage extends HookConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final history = ref.watch(playerHistoProvider);
    final historyNotifier = ref.read(playerHistoProvider.notifier);

    return ElocapsTemplate(
      child: Refresher(
        onRefresh: () async {
          await historyNotifier.loadHisto(user.id);
        },
        child: Column(
          children: [
            const SizedBox(height: 20),
            const AlignLeftText(
              ElocapsTextConstant.history,
              padding: EdgeInsets.symmetric(horizontal: 30),
            ),
            const SizedBox(height: 20),
            AsyncChild(
              value: history,
              builder: (context, games) {
                games.sort((a, b) => b.timestamp.compareTo(a.timestamp));
                return Column(
                    children: games.map((e) => GameCard(game: e)).toList());
              },
            ),
          ],
        ),
      ),
    );
  }
}
