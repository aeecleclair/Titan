import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScore extends StatelessWidget {
  final int score;
  final int scoreRecord;
  const GameScore({
    Key? key,
    required this.score,
    required this.scoreRecord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _TextWidget(title: 'S C O R E', number: score.toString()),
        _TextWidget(title: 'R E C O R D', number: scoreRecord.toString())
      ],
    );
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
