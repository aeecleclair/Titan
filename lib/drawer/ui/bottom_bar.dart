import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/drawer/tools/constants.dart';
import 'package:myecl/login/router.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:qlevar_router/qlevar_router.dart';

class BottomBar extends ConsumerWidget {
  const BottomBar({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authTokenProvider.notifier);
    final isCachingNotifier = ref.watch(isCachingProvider.notifier);
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  await showDialog(
                      context: QR.context!,
                      builder: (BuildContext context) => CustomDialogBox(
                          descriptions: DrawerTextConstants.logingOut,
                          title: DrawerTextConstants.logOut,
                          onYes: () {
                            auth.deleteToken();
                            isCachingNotifier.set(false);
                            displayToast(context, TypeMsg.msg,
                                DrawerTextConstants.logOut);
                            QR.to(LoginRouter.root);
                          }));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 25,
                    ),
                    HeroIcon(
                      HeroIcons.arrowRightOnRectangle,
                      color: DrawerColorConstants.lightText,
                      size: 27,
                    ),
                    Container(
                      width: 15,
                    ),
                    Text(DrawerTextConstants.logOut,
                        style: TextStyle(
                          color: DrawerColorConstants.lightText,
                          fontSize: 18,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 30,
        )
      ],
    );
  }
}
