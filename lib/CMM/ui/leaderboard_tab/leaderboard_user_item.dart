import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myecl/CMM/class/cmm_score.dart';

class CMMLeaderBoardUserItem extends StatelessWidget {
  final CMMScoreUser score;
  const CMMLeaderBoardUserItem({super.key, required this.score});

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
                Text(
                  "${score.position}. ",
                ),
                Expanded(
                  child: AutoSizeText(
                    score.user.nickname ??
                        ("${score.user.firstname} ${score.user.name}"),
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
