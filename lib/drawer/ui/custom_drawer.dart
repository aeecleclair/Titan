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
                              text:
                                  "Ce site est la version Web de l'application MyECL. Nous vous invitons à télécharger l'application. N'utilisez ce site qu'en cas de problème avec l'application.\n"),
                          TextSpan(
                              text:
                                  "https://play.google.com/store/apps/details?id=fr.myecl.titan",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Clipboard.setData(const ClipboardData(
                                      text:
                                          "https://play.google.com/store/apps/details?id=fr.myecl.titan"));
                                  displayToast(context, TypeMsg.msg, "Copié !");
                                }),
                          const TextSpan(
                            text: " ou ",
                          ),
                          TextSpan(
                              text:
                                  "https://apps.apple.com/fr/app/myecl/id6444443430",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Clipboard.setData(const ClipboardData(
                                      text:
                                          "https://apps.apple.com/fr/app/myecl/id6444443430"));
                                  displayToast(context, TypeMsg.msg, "Copié !");
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
