import 'package:flutter/material.dart';
import 'package:titan/feed/router.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class FeedTemplate extends StatelessWidget {
  final Widget child;
  const FeedTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.background,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TopBar(root: FeedRouter.root),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
