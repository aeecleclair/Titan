import 'package:flutter/material.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:myecl/vote/router.dart';
import 'package:myecl/vote/tools/constants.dart';

class VoteTemplate extends StatelessWidget {
  final Widget child;
  const VoteTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopBar(
          title: VoteTextConstants.vote,
          root: VoteRouter.root,
        ),
        Expanded(child: child),
      ],
    );
  }
}
