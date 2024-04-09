import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/elocaps/providers/player_histo_provider.dart';
import 'package:myecl/elocaps/class/game.dart';

class ButtonCard extends HookConsumerWidget {
  final Game game;
  final Future<bool> Function(Game) validateOrCancelledGame;
  final String validateOrCancelled;

  const ButtonCard({
    super.key,
    required this.game,
    required this.validateOrCancelledGame,
    required this.validateOrCancelled,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(userProvider);
    final historyNotifier = ref.read(playerHistoProvider.notifier);
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          await validateOrCancelledGame(game);
          await historyNotifier.loadHisto(me.id);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: const Border.fromBorderSide(
                BorderSide(color: Colors.white, width: 1)),
          ),
          child: Text(validateOrCancelled,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
