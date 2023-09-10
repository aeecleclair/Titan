import 'package:flutter/material.dart';
import 'package:myecl/event/router.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';

class EventTemplate extends StatelessWidget {
  final Widget child;
  const EventTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TopBar(
            title: EventTextConstants.title,
            root: EventRouter.root,
          ),
          Expanded(child: child)
        ],
      ),
    );
  }
}
