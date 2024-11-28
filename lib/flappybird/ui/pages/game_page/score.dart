import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/flappybird/providers/bird_provider.dart';
import 'package:myecl/flappybird/providers/current_best_score.dart';
import 'package:myecl/drawer/providers/theme_provider.dart';
import 'package:myecl/flappybird/tools/constants.dart';

class GameScore extends HookConsumerWidget {
  const GameScore({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bird = ref.watch(birdProvider);
    final record = ref.watch(bestScoreProvider);
    final isDarkTheme = ref.watch(themeProvider);
    return Expanded(
      child: Container(
        color: FlappyBirdColors(isDarkTheme).land,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _TextWidget(title: 'S C O R E', number: bird.score.toString()),
            _TextWidget(title: 'R E C O R D', number: record.toString()),
          ],
        ),
      ),
    );
  }
}

class _TextWidget extends ConsumerWidget {
  const _TextWidget({
    required this.title,
    required this.number,
  });

  final String title;
  final String number;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          number,
          style: GoogleFonts.silkscreen(
            textStyle: TextStyle(
              color: FlappyBirdColors(isDarkTheme).text,
              fontSize: 25,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          title,
          style: GoogleFonts.silkscreen(
            textStyle: TextStyle(
              color: FlappyBirdColors(isDarkTheme).text,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
