import 'package:flutter/material.dart';
import 'package:titan/event/router.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:titan/tools/constants.dart';

class EventTemplate extends StatelessWidget {
  final Widget child;
  const EventTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: ColorConstants.background),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TopBar(root: EventRouter.root),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
