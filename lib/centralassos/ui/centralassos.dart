import 'package:flutter/material.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:myecl/centralassos/tools/constants.dart';
import 'package:myecl/centralassos/router.dart';

class CentralassociationTemplate extends StatelessWidget {
  final Widget child;
  const CentralassociationTemplate({super.key, required this.child});

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
                title: CentralassociationTextConstants.centralassociation,
                root: CentralassociationRouter.root,
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
