import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myecl/CMM/class/cmm_score.dart';

class CMMLeaderBoardPromoItem extends StatelessWidget {
  final CMMScorePromo score;
  const CMMLeaderBoardPromoItem({super.key, required this.score});

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
                    score.promo.toString(),
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
