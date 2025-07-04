import 'package:flutter/material.dart';
import 'package:titan/navigation/ui/top_bar.dart';

class FeedTemplate extends StatelessWidget {
  final Widget child;
  const FeedTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TopBar(),
        Expanded(child: child),
      ],
    );
  }
}
