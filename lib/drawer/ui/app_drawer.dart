import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/amap/ui/amap.dart';
import 'package:myecl/booking/ui/booking.dart';
import 'package:myecl/cinema/ui/cinema.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/drawer/providers/is_web_format_provider.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/drawer/ui/custom_drawer.dart';
import 'package:myecl/event/ui/event.dart';
import 'package:myecl/home/ui/home.dart';
import 'package:myecl/loan/ui/loan.dart';
import 'package:myecl/vote/ui/vote.dart';
import 'package:myecl/tombola/ui/tombola.dart';

class AppDrawer extends HookConsumerWidget {
  static Duration duration = const Duration(milliseconds: 200);
  static const double maxSlide = 255;
  static const dragRigthStartVal = 60;
  static const dragLeftStartVal = maxSlide - 20;
  static bool shouldDrag = false;

  const AppDrawer({Key? key}) : super(key: key);

  Widget getPage(ModuleType page, SwipeControllerNotifier controllerNotifier,
      AnimationController controller) {
    switch (page) {
      case ModuleType.calendar:
        return HomePage(
            controllerNotifier: controllerNotifier, controller: controller);
      case ModuleType.booking:
        return BookingHomePage(
            controllerNotifier: controllerNotifier, controller: controller);
      case ModuleType.loan:
        return LoanHomePage(
            controllerNotifier: controllerNotifier, controller: controller);
      case ModuleType.amap:
        return AmapHomePage(
            controllerNotifier: controllerNotifier, controller: controller);
      case ModuleType.admin:
        return AdminHomePage(
            controllerNotifier: controllerNotifier, controller: controller);
      case ModuleType.event:
        return EventHomePage(
            controllerNotifier: controllerNotifier, controller: controller);
      case ModuleType.vote:
        return VoteHomePage(
            controllerNotifier: controllerNotifier, controller: controller);
      case ModuleType.tombola:
        return TombolaHomePage(
            controllerNotifier: controllerNotifier, controller: controller);
      case ModuleType.cinema:
        return CinemaHomePage(
            controllerNotifier: controllerNotifier, controller: controller);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController =
        useAnimationController(duration: duration, initialValue: 1);
    final controller = ref.watch(swipeControllerProvider(animationController));
    final controllerNotifier =
        ref.watch(swipeControllerProvider(animationController).notifier);
    final page = ref.watch(pageProvider);
    final isWebFormat = ref.watch(isWebFormatProvider);
    if (isWebFormat) {
      controllerNotifier.close();
    }
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
                  double scaleVal = 1 - (isWebFormat ? 0 :(animationVal * 0.3));
                  double cornerval = isWebFormat ? 0 :30.0 * animationVal;
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
                                  getPage(page, controllerNotifier, controller),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    onEnter: (event) {
                                      if (controller.isCompleted) {
                                        controllerNotifier.close();
                                      } else {
                                        controllerNotifier.open();
                                      }
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
