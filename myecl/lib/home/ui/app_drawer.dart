import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/home/providers/swipe_provider.dart';
import 'package:myecl/home/ui/custom_drawer.dart';
import 'package:myecl/user/providers/user_provider.dart';

// class AppDrawer2 extends HookConsumerWidget {
//   static Duration duration = const Duration(milliseconds: 200);
//   static const double maxSlide = 255;
//   static const dragRigthStartVal = 60;
//   static const dragLeftStartVal = maxSlide - 20;
//   static bool shouldDrag = false;
//   late final _controller;

//   int indexFolder = 0;
//   int indexPage = 0;

//   List<String> modules = [
//     "Accueil",
//     "Réservation",
//     "Réservation 2",
//     "Réservation 3",
//     "Pret",
//     "Module 5",
//     "Module 6",
//     "Module 7",
//     "Module 8",
//     "Module 9",
//     "Module 10",
//   ];

//   final page = 0;



//   StatefulWidget getPage() {
//     switch (indexPage) {
//       default:
//         return const Scaffold();
//     }
//   }

//   void changePage(int i) {
//     // page.value = i;
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

//     final _controller = useAnimationController(duration: duration);

//       void close() {
//       _controller.reverse();
//     }

//     void open() {
//       _controller.forward();
//     }

//     void toggle() {
//       if (_controller.isCompleted) {
//         close();
//       } else {
//         open();
//       }
//     }

//     void _onDragStart(DragStartDetails startDetails) {
//       bool isDarggingFromLeft = _controller.isDismissed &&
//           startDetails.globalPosition.dx < dragRigthStartVal;
//       bool isDarggingFromRight = !_controller.isDismissed &&
//           startDetails.globalPosition.dx > dragLeftStartVal;
//       shouldDrag = isDarggingFromLeft || isDarggingFromRight;
//     }

//     void _onDragUpdate(DragUpdateDetails updateDetails) {
//       if (shouldDrag) {
//         double delta = updateDetails.primaryDelta! / maxSlide;
//         _controller.value += delta;
//       }
//     }

//     void _onDragEnd(DragEndDetails endDetails) {
//       if (!_controller.isDismissed && !_controller.isCompleted) {
//         double _minFlingVelocity = 365.0;
//         double dragVelocity = endDetails.velocity.pixelsPerSecond.dx.abs();
//         if (dragVelocity >= _minFlingVelocity) {
//           double visualVelovity = endDetails.velocity.pixelsPerSecond.dx /
//               MediaQuery.of(useContext()).size.width;
//           _controller.fling(velocity: visualVelovity);
//         } else if (_controller.value < 0.5) {
//           close();
//         } else {
//           open();
//         }
//       }
//     }
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
//                   Customdrawer(
//                       modules: modules,
//                       changePage: changePage,
//                       toggle: toggle,
//                       indexPage: indexPage),
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

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  static _AppDrawerState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AppDrawerState>();
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer>
    with SingleTickerProviderStateMixin {
  static Duration duration = const Duration(milliseconds: 200);
  late AnimationController _controller;
  static const double maxSlide = 255;
  static const dragRigthStartVal = 60;
  static const dragLeftStartVal = maxSlide - 20;
  static bool shouldDrag = false;

  int indexFolder = 0;
  int indexPage = 0;

  List<String> modules = [
    "Accueil",
    "Réservation",
    "Réservation 2",
    "Réservation 3",
    "Pret",
    "Module 5",
    "Module 6",
    "Module 7",
    "Module 8",
    "Module 9",
    "Module 10",
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: _AppDrawerState.duration);
  }

  void close() {
    _controller.reverse();
  }

  void open() {
    _controller.forward();
  }

  void toggle() {
    if (_controller.isCompleted) {
      close();
    } else {
      open();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _onDragStart(DragStartDetails startDetails) {
    bool isDarggingFromLeft = _controller.isDismissed &&
        startDetails.globalPosition.dx < dragRigthStartVal;
    bool isDarggingFromRight = !_controller.isDismissed &&
        startDetails.globalPosition.dx > dragLeftStartVal;
    shouldDrag = isDarggingFromLeft || isDarggingFromRight;
  }

  void _onDragUpdate(DragUpdateDetails updateDetails) {
    if (shouldDrag) {
      double delta = updateDetails.primaryDelta! / maxSlide;
      _controller.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails endDetails) {
    if (!_controller.isDismissed && !_controller.isCompleted) {
      double _minFlingVelocity = 365.0;
      double dragVelocity = endDetails.velocity.pixelsPerSecond.dx.abs();
      if (dragVelocity >= _minFlingVelocity) {
        double visualVelovity = endDetails.velocity.pixelsPerSecond.dx /
            MediaQuery.of(context).size.width;
        _controller.fling(velocity: visualVelovity);
      } else if (_controller.value < 0.5) {
        close();
      } else {
        open();
      }
    }
  }

  StatefulWidget getPage() {
    switch (indexPage) {
      default:
        return const Scaffold();
    }
  }

  void changeFolder(int i) {
    setState(() {
      indexFolder = i;
    });
  }

  void changePage(int i) {
    setState(() {
      indexPage = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
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
                  CustomDrawer(),
                  Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()
                        ..translate(translateVal)
                        ..scale(scaleVal),
                      child: GestureDetector(
                          onTap: () {
                            if (_controller.isCompleted) {
                              close();
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(cornerval),
                            child: getPage(),
                          )))
                ],
              );
            }));
  }
}
