import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/drawer/ui/custom_drawer.dart';
import 'package:myecl/home/ui/home.dart';

class AppDrawer extends HookConsumerWidget {
  static Duration duration = const Duration(milliseconds: 200);
  static const double maxSlide = 255;
  static const dragRigthStartVal = 60;
  static const dragLeftStartVal = maxSlide - 20;
  static bool shouldDrag = false;

  const AppDrawer({Key? key}) : super(key: key);

  StatefulWidget getPage(int page, SwipeControllerNotifier _controllerNotifier) {
    switch (page) {
      case 0:
        return Home(controllerNotifier: _controllerNotifier);
      default:
        return Scaffold(
          body: Center(
            child: Text(page.toString()),
          ),
        );
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

// TODO: implement hook / Param Page

// class AppDrawer extends StatefulWidget {
//   const AppDrawer({Key? key}) : super(key: key);

//   static _AppDrawerState? of(BuildContext context) =>
//       context.findAncestorStateOfType<_AppDrawerState>();
//   @override
//   _AppDrawerState createState() => _AppDrawerState();
// }

// class _AppDrawerState extends State<AppDrawer>
//     with SingleTickerProviderStateMixin {
//   static Duration duration = const Duration(milliseconds: 200);
//   late AnimationController _controller;
//   static const double maxSlide = 255;
//   static const dragRigthStartVal = 60;
//   static const dragLeftStartVal = maxSlide - 20;
//   static bool shouldDrag = false;

//   int indexPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         AnimationController(vsync: this, duration: _AppDrawerState.duration);
//   }

//   void close() {
//     _controller.reverse();
//   }

//   void open() {
//     _controller.forward();
//   }

//   void toggle() {
//     if (_controller.isCompleted) {
//       close();
//     } else {
//       open();
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }

//   void _onDragStart(DragStartDetails startDetails) {
//     bool isDarggingFromLeft = _controller.isDismissed &&
//         startDetails.globalPosition.dx < dragRigthStartVal;
//     bool isDarggingFromRight = !_controller.isDismissed &&
//         startDetails.globalPosition.dx > dragLeftStartVal;
//     shouldDrag = isDarggingFromLeft || isDarggingFromRight;
//   }

//   void _onDragUpdate(DragUpdateDetails updateDetails) {
//     if (shouldDrag) {
//       double delta = updateDetails.primaryDelta! / maxSlide;
//       _controller.value += delta;
//     }
//   }

//   void _onDragEnd(DragEndDetails endDetails) {
//     if (!_controller.isDismissed && !_controller.isCompleted) {
//       double _minFlingVelocity = 365.0;
//       double dragVelocity = endDetails.velocity.pixelsPerSecond.dx.abs();
//       if (dragVelocity >= _minFlingVelocity) {
//         double visualVelovity = endDetails.velocity.pixelsPerSecond.dx /
//             MediaQuery.of(context).size.width;
//         _controller.fling(velocity: visualVelovity);
//       } else if (_controller.value < 0.5) {
//         close();
//       } else {
//         open();
//       }
//     }
//   }

//   StatefulWidget getPage() {
//     switch (indexPage) {
//       default:
//         return const Scaffold();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onHorizontalDragStart: _onDragStart,
//         onHorizontalDragUpdate: _onDragUpdate,
//         onHorizontalDragEnd: _onDragEnd,
//         onTap: () {},
//         child: AnimatedBuilder(
//             animation: _controller,
//             builder: (BuildContext context, _) {
//               double animationVal = _controller.value;
//               double translateVal = animationVal * maxSlide;
//               double scaleVal = 1 - (animationVal * 0.3);
//               double cornerval = 30.0 * animationVal;
//               return Stack(
//                 children: [
//                   const CustomDrawer(),
//                   Transform(
//                       alignment: Alignment.centerLeft,
//                       transform: Matrix4.identity()
//                         ..translate(translateVal)
//                         ..scale(scaleVal),
//                       child: GestureDetector(
//                           onTap: () {
//                             if (_controller.isCompleted) {
//                               close();
//                             }
//                           },
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(cornerval),
//                             child: getPage(),
//                           )))
//                 ],
//               );
//             }));
//   }
// }
