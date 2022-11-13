import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/amap/ui/amap.dart';
import 'package:myecl/booking/ui/booking.dart';
import 'package:myecl/cinema/ui/cinema.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/drawer/ui/custom_drawer.dart';
import 'package:myecl/event/ui/event.dart';
import 'package:myecl/home/ui/home.dart';
import 'package:myecl/loan/ui/loan.dart';
import 'package:myecl/settings/ui/settings.dart';

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
      case ModuleType.settings:
        return SettingsHomePage(
            controllerNotifier: controllerNotifier, controller: controller);
      case ModuleType.home:
        return HomePage(controllerNotifier: controllerNotifier);
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
      case ModuleType.cinema:
        return CinemaHomePage(
            controllerNotifier: controllerNotifier, controller: controller);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(duration: duration);
    final controller = ref.watch(swipeControllerProvider(animationController));
    final controllerNotifier =
        ref.watch(swipeControllerProvider(animationController).notifier);
    final page = ref.watch(pageProvider);
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
              double scaleVal = 1 - (animationVal * 0.3);
              double cornerval = 30.0 * animationVal;
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
                          child: IgnorePointer(
                            ignoring: controller.isCompleted,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(cornerval),
                              child:
                                  getPage(page, controllerNotifier, controller),
                            ),
                          )))
                ],
              );
            }));
  }
}
