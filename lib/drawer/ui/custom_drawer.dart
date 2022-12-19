import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/drawer/tools/constants.dart';
import 'package:myecl/drawer/ui/bottom_bar.dart';
import 'package:myecl/drawer/ui/fake_page.dart';
import 'package:myecl/drawer/ui/list_module.dart';
import 'package:myecl/drawer/ui/top_bar.dart';
import 'package:myecl/tools/functions.dart';

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
              DrawerColorConstants.lightBlue,
              DrawerColorConstants.darkBlue,
              // DrawerColorConstants.darkBlue,
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
            if (kIsWeb)
              Positioned(
                top: 40,
                left: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 220),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          const TextSpan(
                              text: DrawerTextConstants
                                  .downloadAppOnMobileDevice),
                          TextSpan(
                              text: DrawerTextConstants.androidAppLink,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Clipboard.setData(const ClipboardData(
                                      text:
                                          DrawerTextConstants.androidAppLink));
                                  displayToast(context, TypeMsg.msg,
                                      DrawerTextConstants.copied);
                                }),
                          const TextSpan(
                            text: DrawerTextConstants.or,
                          ),
                          TextSpan(
                              text:
                                  DrawerTextConstants.iosAppLink,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Clipboard.setData(const ClipboardData(
                                      text:DrawerTextConstants.iosAppLink));
                                  displayToast(context, TypeMsg.msg, DrawerTextConstants.copied);
                                })
                        ]),
                      ),
                    ),
                  ),
                ),
              )
          ]),
        ),
      ),
    );
  }
}
