import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/drawer/providers/display_quit_popup.dart';
import 'package:myecl/drawer/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/dialog.dart';

class QuitDialog extends HookConsumerWidget {
  const QuitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authTokenProvider.notifier);
    final isCachingNotifier = ref.watch(isCachingProvider.notifier);
    final displayQuitNotifier = ref.watch(displayQuitProvider.notifier);
    return GestureDetector(
        onTap: () {
          displayQuitNotifier.setDisplay(false);
        },
        child: Container(
            color: Colors.black54,
            child: GestureDetector(
              onTap: () {},
              child: CustomDialogBox(
                  descriptions: DrawerTextConstants.logingOut,
                  title: DrawerTextConstants.logOut,
                  onYes: () {
                    auth.deleteToken();
                    isCachingNotifier.set(false);
                    displayToast(
                        context, TypeMsg.msg, DrawerTextConstants.logOut);
                    displayQuitNotifier.setDisplay(false);
                  }),
            )));
  }
}
