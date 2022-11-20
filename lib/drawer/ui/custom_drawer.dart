import 'package:flutter/material.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/drawer/tools/constants.dart';
import 'package:myecl/drawer/ui/bottom_bar.dart';
import 'package:myecl/drawer/ui/fake_page.dart';
import 'package:myecl/drawer/ui/list_module.dart';
import 'package:myecl/drawer/ui/top_bar.dart';

class CustomDrawer extends StatelessWidget {
  final SwipeControllerNotifier controllerNotifier;
  const CustomDrawer({Key? key, required this.controllerNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              DrawerColorConstants.darkBlue,
              DrawerColorConstants.lightBlue,
              DrawerColorConstants.darkBlue,
            ])),
        child: SafeArea(
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TopBar(controllerNotifier: controllerNotifier),
                BottomBar(controllerNotifier: controllerNotifier),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: SizedBox(
                            width: 200,
                            height:
                                MediaQuery.of(context).size.height * 4.4 / 10,
                            child: ListModule(
                                controllerNotifier: controllerNotifier))),
                    const FakePage(),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
