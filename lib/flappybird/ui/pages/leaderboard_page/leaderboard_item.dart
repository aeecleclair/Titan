import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class LeaderBoardItem extends StatelessWidget {
  final CoreUserSimple user;
  final int value;
  final int position;
  const LeaderBoardItem({
    super.key,
    required this.user,
    required this.position,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.silkscreen(
      textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: position == 1
            ? Colors.yellow.shade700
            : position == 2
                ? Colors.grey.shade400
                : position == 3
                    ? Colors.brown.shade400
                    : Colors.white,
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
                  "$position. ",
                  style: style,
                ),
                Expanded(
                  child: AutoSizeText(
                    user.nickname ?? ("${user.firstname} ${user.name}"),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: style,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value.toString(),
            style: style,
          ),
        ],
      ),
    );
  }
}
