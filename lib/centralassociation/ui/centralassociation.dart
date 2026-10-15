import 'package:flutter/material.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:titan/centralassociation/tools/constants.dart';
import 'package:titan/centralassociation/router.dart';

class CentralassociationTemplate extends StatelessWidget {
  final Widget child;
  const CentralassociationTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TopBar(
              title: CentralassociationTextConstants.centralassociation,
              root: CentralassociationRouter.root,
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
