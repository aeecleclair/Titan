import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/flappybird/providers/game_state_provider.dart';
import 'package:myecl/drawer/providers/theme_provider.dart';
import 'package:myecl/flappybird/tools/constants.dart';

class StartScreen extends HookConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameStarted = ref.watch(gameStateProvider);
    final isDarkTheme = ref.watch(themeProvider);
    return !gameStarted
        ? Container(
            alignment: const Alignment(0, -0.4),
            child: Text(
              'T A P   T O   P L A Y',
              style: GoogleFonts.silkscreen(
                textStyle: TextStyle(
                  color: FlappyBirdColors(isDarkTheme).text,
                  fontSize: 20,
                ),
              ),
            ),
          )
        : Container();
  }
}
