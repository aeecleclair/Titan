import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/drawer/providers/animation_provider.dart';
import 'package:titan/drawer/providers/display_quit_popup.dart';
import 'package:titan/drawer/providers/is_email_dialog_open.dart';
import 'package:titan/drawer/providers/is_web_format_provider.dart';
import 'package:titan/drawer/providers/should_setup_provider.dart';
import 'package:titan/drawer/providers/swipe_provider.dart';
import 'package:titan/drawer/ui/custom_drawer.dart';
import 'package:titan/service/tools/setup.dart';
import 'package:titan/drawer/ui/quit_dialog.dart';
import 'package:titan/drawer/ui/email_change_popup.dart';
import 'package:titan/user/providers/user_provider.dart';

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
    // We are logged in, so we can set up the notification
    final user = ref.watch(userProvider);
    final animationController = useAnimationController(
      duration: duration,
      initialValue: 1,
    );
    final animationNotifier = ref.read(animationProvider.notifier);
    final controller = ref.watch(swipeControllerProvider(animationController));
    final controllerNotifier = ref.watch(
      swipeControllerProvider(animationController).notifier,
    );
    final isWebFormat = ref.watch(isWebFormatProvider);
    final displayQuit = ref.watch(displayQuitProvider);
    final isEmailPopupOpen = ref.watch(isEmailDialogOpenProvider);
    final shouldSetup = ref.watch(shouldSetupProvider);
    final shouldSetupNotifier = ref.read(shouldSetupProvider.notifier);
    if (isWebFormat) {
      controllerNotifier.close();
    }

    Future(() {
      animationNotifier.setController(animationController);
      if (!kIsWeb && user.id != "" && shouldSetup) {
        setUpNotification(ref);
        shouldSetupNotifier.setShouldSetup();
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onHorizontalDragStart: controllerNotifier.onDragStart,
            onHorizontalDragUpdate: controllerNotifier.onDragUpdate,
            onHorizontalDragEnd: (details) => controllerNotifier.onDragEnd(
              details,
              MediaQuery.of(context).size.width,
            ),
            onTap: () {},
            child: AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, _) {
                double animationVal = controller.value;
                double translateVal = animationVal * maxSlide;
                double scaleVal = 1 - (isWebFormat ? 0 : (animationVal * 0.3));
                double cornerVal = isWebFormat ? 0 : 30.0 * animationVal;
                return Stack(
                  children: [
                    const CustomDrawer(),
                    Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()
                        ..translate(translateVal)
                        ..scale(scaleVal),
                      child: GestureDetector(
                        onTap: () {
                          if (controller.isCompleted) {
                            controllerNotifier.close();
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(cornerVal),
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.white,
                                child: IgnorePointer(
                                  ignoring: controller.isCompleted,
                                  child: child,
                                ),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                onEnter: (event) {
                                  controllerNotifier.toggle();
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  width: 20,
                                  height: double.infinity,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          if (isEmailPopupOpen) const EmailChangeDialog(),
          if (displayQuit) const QuitDialog(),
        ],
      ),
    );
  }
}
