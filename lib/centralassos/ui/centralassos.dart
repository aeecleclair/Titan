import 'package:flutter/material.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:titan/centralassos/tools/constants.dart';
import 'package:titan/centralassos/router.dart';

class CentralassosTemplate extends StatelessWidget {
  final Widget child;
  const CentralassosTemplate({super.key, required this.child});

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
                title: CentralassosTextConstants.centralassos,
                root: CentralassosRouter.root,
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
