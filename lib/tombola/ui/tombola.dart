import 'package:flutter/material.dart';
import 'package:myecl/tombola/router.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tools/ui/top_bar.dart';

class TombolaTemplate extends StatelessWidget {
  final Widget child;
  const TombolaTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              const TopBar(
                title: TombolaTextConstants.raffle,
                root: RaffleRouter.root,
              ),
              Expanded(child: child)
            ],
          ),
        ),
      ),
    );
  }
}
