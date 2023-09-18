import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/module_root_list_provider.dart';
import 'package:myecl/others/tools/constants.dart';
import 'package:myecl/tools/providers/path_forwarding_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class NoModulePage extends HookConsumerWidget {
  const NoModulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moduleVisibilityList = ref.watch(moduleRootListProvider);
    final pathForwarding = ref.read(pathForwardingProvider);
    moduleVisibilityList.maybeWhen(
        data: (data) {
          QR.to(pathForwarding.path);
        },
        orElse: () {});
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Spacer(
              flex: 2,
            ),
            HeroIcon(
              HeroIcons.cubeTransparent,
              size: 100,
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                OthersTextConstants.noModule,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Spacer(
              flex: 3,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
