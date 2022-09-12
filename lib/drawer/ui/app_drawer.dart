import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/amap/ui/amap.dart';
import 'package:myecl/booking/ui/booking.dart';
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

  Widget getPage(ModuleType page, SwipeControllerNotifier _controllerNotifier) {
    switch (page) {
      case ModuleType.settings:
        return SettingsPage(controllerNotifier: _controllerNotifier);
      case ModuleType.home:
        return HomePage(controllerNotifier: _controllerNotifier);
      case ModuleType.booking:
        return BookingPage(controllerNotifier: _controllerNotifier);
      case ModuleType.loan:
        return LoanPage(controllerNotifier: _controllerNotifier);
      case ModuleType.amap:
        return AmapPage(controllerNotifier: _controllerNotifier);
      case ModuleType.admin:
        return AdminPage(controllerNotifier: _controllerNotifier);
      case ModuleType.event:
        return EventPage(controllerNotifier: _controllerNotifier);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(duration: duration);
    final _controller = ref.watch(swipeControllerProvider(animationController));
    final _controllerNotifier =
        ref.watch(swipeControllerProvider(animationController).notifier);
    final page = ref.watch(pageProvider);
    return GestureDetector(
        onHorizontalDragStart: _controllerNotifier.onDragStart,
        onHorizontalDragUpdate: _controllerNotifier.onDragUpdate,
        onHorizontalDragEnd: (details) => _controllerNotifier.onDragEnd(
            details, MediaQuery.of(context).size.width),
        onTap: () {},
        child: AnimatedBuilder( 
            animation: _controller,
            builder: (BuildContext context, _) {
              double animationVal = _controller.value;
              double translateVal = animationVal * maxSlide;
              double scaleVal = 1 - (animationVal * 0.3);
              double cornerval = 30.0 * animationVal;
              return Stack(
                children: [
                  CustomDrawer(controllerNotifier: _controllerNotifier),
                  Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()
                        ..translate(translateVal)
                        ..scale(scaleVal),
                      child: GestureDetector(
                          onTap: () {
                            if (_controller.isCompleted) {
                              _controllerNotifier.close();
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(cornerval),
                            child: getPage(page, _controllerNotifier),
                          )))
                ],
              );
            }));
  }
}
