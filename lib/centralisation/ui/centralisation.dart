import 'package:flutter/material.dart';
import 'package:titan/centralisation/router.dart';
import 'package:titan/centralisation/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class CentralisationTemplate extends StatelessWidget {
  final Widget child;
  const CentralisationTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TopBar(
                title: CentralisationTextConstants.centralisation,
                root: CentralisationRouter.root,
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
