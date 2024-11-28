import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myecl/flappybird/class/score.dart';
import 'package:myecl/drawer/providers/theme_provider.dart';
import 'package:myecl/flappybird/tools/constants.dart';

class LeaderBoardItem extends ConsumerWidget {
  final Score score;
  const LeaderBoardItem({super.key, required this.score});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeProvider);
    final style = GoogleFonts.silkscreen(
      textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: score.position == 1
            ? Colors.yellow.shade700
            : score.position == 2
                ? Colors.grey.shade400
                : score.position == 3
                    ? Colors.brown.shade400
                    : FlappyBirdColors(isDarkTheme).text,
      ),
    );
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  "${score.position}. ",
                  style: style,
                ),
                Expanded(
                  child: AutoSizeText(
                    score.user.nickname ??
                        ("${score.user.firstname} ${score.user.name}"),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: style,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${score.value}",
            style: style,
          ),
        ],
      ),
    );
  }
}
