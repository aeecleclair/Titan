import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/is_web_format_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/drawer/tools/constants.dart';
import 'package:myecl/drawer/ui/bottom_bar.dart';
import 'package:myecl/drawer/ui/fake_page.dart';
import 'package:myecl/drawer/ui/list_module.dart';
import 'package:myecl/drawer/ui/drawer_top_bar.dart';

class CustomDrawer extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const CustomDrawer({Key? key, required this.controllerNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWebFormat = ref.watch(isWebFormatProvider);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              DrawerColorConstants.lightBlue,
              DrawerColorConstants.darkBlue,
              // DrawerColorConstants.darkBlue,
            ])),
        child: SafeArea(
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DrawerTopBar(controllerNotifier: controllerNotifier),
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
                    isWebFormat
                        ? Container(
                            width: MediaQuery.of(context).size.width - 220)
                        : const FakePage(),
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
