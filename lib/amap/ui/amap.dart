import 'package:flutter/material.dart';
import 'package:myecl/amap/ui/top_bar.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/amap/ui/page_switcher.dart';

class AmapPage extends StatelessWidget {
  final SwipeControllerNotifier controllerNotifier;
  const AmapPage({Key? key, required this.controllerNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/test3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            TopBar(
              controllerNotifier: controllerNotifier,
            ),
             const Expanded(child: PageSwitcher()),
          ],
        ),
      ),
    );
  }
}
