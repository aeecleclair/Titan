import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/providers/player_histo_provider.dart';
import 'package:myecl/elocaps/ui/elocaps.dart';
import 'package:myecl/elocaps/ui/pages/history_page/game_card.dart';
import 'package:myecl/user/providers/user_provider.dart';

class HistoryPage extends HookConsumerWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final myHisto = ref.watch(playerHistoProvider);

    return ElocapsTemplate(
        child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
              "Bonjour bienvenue dans ton historique de partie ${user.nickname}"),
          const SizedBox(height: 20),
          ...myHisto.when(
            data: (data) => data.map((e) => GameCard(game: e)),
            error: (error, stackTrace) {
              return [Text("erreur : ${error.toString()}")];
            },
            loading: () {
              return [const CircularProgressIndicator()];
            },
          ),
        ],
      ),
    ));
  }
}
