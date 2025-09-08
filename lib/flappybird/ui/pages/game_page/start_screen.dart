import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/flappybird/providers/game_state_provider.dart';

class StartScreen extends HookConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameStarted = ref.watch(gameStateProvider);
    return !gameStarted
        ? Container(
            alignment: const Alignment(0, -0.4),
            child: Text(
              'T A P   T O   P L A Y',
              style: GoogleFonts.silkscreen(
                textStyle: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        : Container();
  }
}
