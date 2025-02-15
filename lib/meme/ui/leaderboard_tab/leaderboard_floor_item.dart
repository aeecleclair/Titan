import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myecl/meme/class/meme_score.dart';

class MemeLeaderBoardFloorItem extends StatelessWidget {
  final MemeScoreFloor score;
  const MemeLeaderBoardFloorItem({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                score.position == 1
                    ? const Icon(
                        Icons.emoji_events,
                        color: Colors.amber,
                      )
                    : Text(
                        "${score.position}. ",
                      ),
                Expanded(
                  child: AutoSizeText(
                    score.floor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: (score.position == 1 ||
                            score.position == 2 ||
                            score.position == 3)
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${score.score}",
          ),
        ],
      ),
    );
  }
}
