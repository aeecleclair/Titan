import 'package:flutter/material.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:titan/vote/router.dart';
import 'package:titan/vote/tools/constants.dart';

class VoteTemplate extends StatelessWidget {
  final Widget child;
  const VoteTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const TopBar(title: VoteTextConstants.vote, root: VoteRouter.root),
          Expanded(child: child),
        ],
      ),
    );
  }
}
