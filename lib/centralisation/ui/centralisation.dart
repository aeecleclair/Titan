import 'package:flutter/material.dart';
import 'package:titan/centralisation/router.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:titan/tools/constants.dart';

class CentralisationTemplate extends StatelessWidget {
  final Widget child;
  const CentralisationTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConstants.background,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TopBar(root: CentralisationRouter.root),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
