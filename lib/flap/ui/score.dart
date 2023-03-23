import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/flap/providers/bird_provider.dart';
import 'package:myecl/flap/providers/current_best_score.dart';

class GameScore extends HookConsumerWidget {
  const GameScore({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bird = ref.watch(birdProvider);
    final record = ref.watch(bestScoreProvider);
    return Expanded(
        child: Container(
            color: Colors.brown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _TextWidget(title: 'S C O R E', number: bird.score.toString()),
                _TextWidget(title: 'R E C O R D', number: record.toString()),
              ],
            )));
  }
}

class _TextWidget extends StatelessWidget {
  const _TextWidget({
    Key? key,
    required this.title,
    required this.number,
  }) : super(key: key);

  final String title;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(number,
            style: GoogleFonts.silkscreen(
                textStyle: const TextStyle(color: Colors.white, fontSize: 25))),
        const SizedBox(
          height: 15,
        ),
        Text(
          title,
          style: GoogleFonts.silkscreen(
              textStyle: const TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ],
    );
  }
}
