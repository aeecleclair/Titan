import 'package:flutter/material.dart';
import 'package:titan/recommendation/router.dart';
import 'package:titan/recommendation/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class RecommendationTemplate extends StatelessWidget {
  final Widget child;
  const RecommendationTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TopBar(
            title: RecommendationTextConstants.recommendation,
            root: RecommendationRouter.root,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
