import 'package:flutter/material.dart';
import 'package:myecl/centralisation/router.dart';
import 'package:myecl/centralisation/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';

class CentralisationTemplate extends StatelessWidget {
  final Widget child;
  const CentralisationTemplate({Key? key, required this.child})
      : super(key: key);

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
                  root: CentralisationRouter.root),
              Expanded(child: child)
            ],
          ),
        ),
      ),
    );
  }
}
