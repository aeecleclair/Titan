import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/drawer/providers/animation_provider.dart';
import 'package:myecl/drawer/providers/is_web_format_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/drawer/ui/custom_drawer.dart';
import 'package:myecl/home/providers/already_displayed_popup.dart';
import 'package:myecl/others/ui/email_change_popup.dart';
import 'package:myecl/tools/providers/should_notify_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class DrawerTemplate extends HookConsumerWidget {
  static Duration duration = const Duration(milliseconds: 200);
  static const double maxSlide = 255;
  static const dragRigthStartVal = 60;
  static const dragLeftStartVal = maxSlide - 20;
  static bool shouldDrag = false;
  final Widget child;

  const DrawerTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController =
        useAnimationController(duration: duration, initialValue: 1);
    final animationNotifier = ref.read(animationProvider.notifier);
    final controller = ref.watch(swipeControllerProvider(animationController));
    final controllerNotifier =
        ref.watch(swipeControllerProvider(animationController).notifier);
    final isWebFormat = ref.watch(isWebFormatProvider);
    final alreadyDisplayed = ref.watch(alreadyDisplayedProvider);
    final alreadyDisplayedNotifier =
        ref.watch(alreadyDisplayedProvider.notifier);
    final shouldNotify = ref.watch(shouldNotifyProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final displayedDialog = useState(false);
    if (isWebFormat) {
      controllerNotifier.close();
    }

    Future(() {
      animationNotifier.setController(animationController);
      if (isLoggedIn &&
          shouldNotify &&
          QR.context != null &&
          !displayedDialog.value &&
          !alreadyDisplayed) {
        displayedDialog.value = true;
        showDialog(
                context: QR.context!,
                builder: (BuildContext context) => const EmailChangeDialog())
            .then((value) {
          alreadyDisplayedNotifier.setAlreadyDisplayed();
        });
      }
    });

    return GestureDetector(
        onHorizontalDragStart: controllerNotifier.onDragStart,
        onHorizontalDragUpdate: controllerNotifier.onDragUpdate,
        onHorizontalDragEnd: (details) => controllerNotifier.onDragEnd(
            details, MediaQuery.of(context).size.width),
        onTap: () {},
        child: AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, _) {
              double animationVal = controller.value;
              double translateVal = animationVal * maxSlide;
              double scaleVal = 1 - (isWebFormat ? 0 : (animationVal * 0.3));
              double cornerval = isWebFormat ? 0 : 30.0 * animationVal;
              return Stack(
                children: [
                  CustomDrawer(controllerNotifier: controllerNotifier),
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
                          borderRadius: BorderRadius.circular(cornerval),
                          child: Stack(
                            children: [
                              IgnorePointer(
                                ignoring: controller.isCompleted,
                                child: child,
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
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              );
            }));
  }
}
