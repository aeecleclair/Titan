import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/seed-library/router.dart';
import 'package:myecl/seed-library/tools/constants.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SeedLibraryTemplate extends HookConsumerWidget {
  final Widget child;
  const SeedLibraryTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meNotifier = ref.watch(asyncUserProvider.notifier);
    print(QR.currentPath);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TopBar(
                title: SeedLibraryTextConstants.seedLibrary,
                root: SeedLibraryRouter.root,
                onMenu: () {
                  tokenExpireWrapper(ref, () async {
                    await meNotifier.loadMe();
                  });
                },
                rightIcon: QR.currentPath == SeedLibraryRouter.root
                    ? IconButton(
                        onPressed: () {
                          QR.to(
                            SeedLibraryRouter.root +
                                SeedLibraryRouter.information,
                          );
                        },
                        icon: const HeroIcon(
                          HeroIcons.informationCircle,
                          color: Colors.black,
                          size: 40,
                        ),
                      )
                    : null,
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
