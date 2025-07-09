import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/feed/router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/class/module.dart';
import 'package:titan/navigation/providers/display_quit_popup.dart';
import 'package:titan/navigation/providers/navbar_animation.dart';
import 'package:titan/navigation/providers/navbar_module_list.dart';
import 'package:titan/navigation/providers/should_setup_provider.dart';
import 'package:titan/router.dart';
import 'package:titan/service/tools/setup.dart';
import 'package:titan/navigation/ui/quit_dialog.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/tools/ui/styleguide/navbar.dart';
import 'package:titan/user/providers/user_provider.dart';

// Global navigator key that can be used to ensure bottom sheets appear above the navbar
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class DrawerTemplate extends HookConsumerWidget {
  static Duration duration = const Duration(milliseconds: 200);
  static const double maxSlide = 255;
  static const dragRightStartVal = 60;
  static const dragLeftStartVal = maxSlide - 20;
  static bool shouldDrag = false;
  final Widget child;

  const DrawerTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final navbarListModule = ref.watch(navbarListModuleProvider);
    final navbarListModuleNotifier = ref.watch(
      navbarListModuleProvider.notifier,
    );
    final displayQuit = ref.watch(displayQuitProvider);
    final shouldSetup = ref.watch(shouldSetupProvider);
    final shouldSetupNotifier = ref.read(shouldSetupProvider.notifier);
    final animation = ref.watch(navbarAnimationProvider);
    final pathForwarding = ref.read(pathForwardingProvider);
    final pathForwardingNotifier = ref.read(pathForwardingProvider.notifier);

    Future(() {
      if (!kIsWeb && user.id != "" && shouldSetup) {
        setUpNotification(ref);
        shouldSetupNotifier.setShouldSetup();
      }
    });

    return Builder(
      builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                child,
                if (pathForwarding.isLoggedIn)
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Visibility(
                      visible: animation!.isCompleted && animation.value == 1.0,
                      child: AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) => Opacity(
                          opacity: animation.value,
                          child: FloatingNavbar(
                            items: [
                              FloatingNavbarItem(
                                module: FeedRouter.module,
                                onTap: () {
                                  pathForwardingNotifier.forward(
                                    FeedRouter.root,
                                  );
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) {
                                    QR.to(FeedRouter.root);
                                  });
                                },
                              ),
                              ...navbarListModule.map((module) {
                                return FloatingNavbarItem(
                                  module: module,
                                  onTap: () {
                                    navbarListModuleNotifier.pushModule(module);
                                    pathForwardingNotifier.forward(module.root);
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          QR.to(module.root);
                                        });
                                  },
                                );
                              }),
                              FloatingNavbarItem(
                                module: Module(
                                  getName: (context) => AppLocalizations.of(
                                    context,
                                  )!.moduleOthers,
                                  description: '',
                                  root: AppRouter.allModules,
                                ),
                                onTap: () {
                                  pathForwardingNotifier.forward(
                                    AppRouter.allModules,
                                  );
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) {
                                    QR.to(AppRouter.allModules);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (displayQuit) const QuitDialog(),
              ],
            ),
          ),
        );
      },
    );
  }
}
