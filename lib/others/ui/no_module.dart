import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/super_admin/providers/module_root_list_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class NoModulePage extends HookConsumerWidget {
  const NoModulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moduleVisibilityList = ref.watch(moduleRootListProvider);
    final pathForwarding = ref.read(pathForwardingProvider);
    moduleVisibilityList.maybeWhen(
      data: (data) {
        QR.to(pathForwarding.path);
      },
      orElse: () {},
    );
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Spacer(flex: 2),
            const HeroIcon(HeroIcons.cubeTransparent, size: 100),
            const SizedBox(height: 50),
            Center(
              child: Text(
                AppLocalizations.of(context)!.othersNoModule,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const Spacer(flex: 3),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
