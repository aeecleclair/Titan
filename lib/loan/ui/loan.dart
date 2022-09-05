import 'package:flutter/material.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/loan/ui/page_switcher.dart';
import 'package:myecl/loan/ui/top_bar.dart';
class LoanPage extends StatelessWidget {
  final SwipeControllerNotifier controllerNotifier;
  const LoanPage({Key? key, required this.controllerNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(
            controllerNotifier: controllerNotifier,
          ),
          const Expanded(child: PageSwitcher()),
        ],
      ),
    );
  }
}