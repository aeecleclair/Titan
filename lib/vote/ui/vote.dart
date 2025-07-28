import 'package:flutter/material.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:titan/vote/router.dart';
import 'package:titan/tools/constants.dart';

class VoteTemplate extends StatelessWidget {
  final Widget child;
  const VoteTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: ColorConstants.background),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TopBar(root: VoteRouter.root),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
