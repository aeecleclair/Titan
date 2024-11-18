import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/calendar/providers/scrolled_provider.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/drawer/providers/animation_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/calendar/router.dart';
import 'package:myecl/home/tools/constant.dart';
import 'package:myecl/tools/providers/path_forwarding_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ModuleUI extends HookConsumerWidget {
  const ModuleUI({super.key, required this.module, required this.size});

  final Module module;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pathForwardingNotifier = ref.read(pathForwardingProvider.notifier);
    final pathForwarding = ref.watch(pathForwardingProvider);
    final hasScrolled = ref.watch(hasScrolledProvider.notifier);
    final animation = ref.watch(animationProvider);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      key: ValueKey(module.root),
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: HomeColorConstants.box,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 25,
            ),
            Center(
              child: module.getIcon(HomeColorConstants.text, size: size),
            ),
            Container(
              width: 20,
            ),
            SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  module.name,
                  style: TextStyle(
                    color: HomeColorConstants.text,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        QR.to(module.root);
        pathForwardingNotifier.forward(module.root);
        if (animation != null) {
          final controllerNotifier =
              ref.watch(swipeControllerProvider(animation).notifier);
          controllerNotifier.toggle();
        }
        if (pathForwarding.path != CalendarRouter.root) {
          hasScrolled.setHasScrolled(false);
        }
      },
    );
  }
}
