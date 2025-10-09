import 'package:flutter/material.dart';
import 'package:titan/cinema/tools/constants.dart';

class TmdbButton extends StatelessWidget {
  final Widget child;
  const TmdbButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: CinemaColorConstants.tmdbColor,
      ),
      child: child,
    );
  }
}
