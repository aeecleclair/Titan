import 'package:flutter/material.dart';
import 'package:myecl/rplace/providers/pixelfocus_providers.dart';
import 'package:myecl/rplace/providers/grid_providers.dart';
import 'package:myecl/rplace/providers/pixelinfo_providers.dart';
import 'package:myecl/rplace/ui/color_picker.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'my_painter.dart';
import 'package:myecl/rplace/providers/pixels_providers.dart';
import 'package:myecl/rplace/providers/userinfo_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/rplace/class/focus.dart';

class CanvasViewer extends HookConsumerWidget {
  const CanvasViewer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pixels = ref.watch(pixelListProvider);
    final gridInfo = ref.watch(gridProvider);
    final focus = ref.watch(focusProvider);
    final focusNotifier = ref.watch(focusProvider.notifier);
    final pixelinfo = ref.watch(pixelInfoProvider.notifier);
    final userinfo = ref.watch(userinfoProvider);

    return AsyncChild(
      value: gridInfo,
      builder: (context, gridInfo) {
        final int nbLigne = gridInfo.nbLigne;
        final int nbColonne = gridInfo.nbColonne;
        final double pixelSize = gridInfo.pixelSize;
        final Duration cooldown = gridInfo.cooldown;

        return InteractiveViewer(
          constrained: false,
          minScale: 0.1,
          maxScale: 15,
          child: SizedBox(
            width: 10 * MediaQuery.of(context).size.width,
            height: 10 * MediaQuery.of(context).size.height,
            child: Center(
              child: GestureDetector(
                onTapDown: (event) {
                  pixelinfo.getPixelInfo(
                    (event.localPosition.dx) ~/ pixelSize,
                    (event.localPosition.dy) ~/ pixelSize,
                  );
                  focusNotifier.setPixelFocus(
                    PixelFocus(
                      x: (event.localPosition.dx) ~/ pixelSize,
                      y: (event.localPosition.dy) ~/ pixelSize,
                      isFocus: true,
                    ),
                  );
                  Future<void> future = showModalBottomSheet(
                    barrierColor: Color.fromARGB(50, 0, 0, 0),
                    context: context,
                    builder: (BuildContext context) {
                      return AsyncChild(
                        value: userinfo,
                        builder: (context, userinfo) {
                          if (DateTime.now().difference(userinfo.lastplaced) <
                              cooldown) {
                            return SizedBox(
                              height: 110,
                              child: Text(
                                "${cooldown - DateTime.now().difference(userinfo.lastplaced)}",
                              ),
                            );
                          } else {
                            return ColorPicker(
                              x: ((event.localPosition.dx) ~/ pixelSize),
                              y: ((event.localPosition.dy) ~/ pixelSize),
                            );
                          }
                        },
                      );
                    },
                  );

                  future.then(
                    (void value) => (focusNotifier.unfocus()),
                  );
                },
                child: Stack(
                  children: [
                    SizedBox(
                      width: pixelSize * nbColonne,
                      height: pixelSize * nbLigne,
                      child: DecoratedBox(
                          decoration: BoxDecoration(color: Color(0xFFC4C4C4))),
                    ),
                    AsyncChild(
                      value: pixels,
                      builder: (context, pixels) {
                        return CustomPaint(
                          size: Size(
                            pixelSize * nbColonne,
                            pixelSize * nbLigne,
                          ),
                          painter: MyPainter(
                            pixels: pixels,
                            pixelSize: pixelSize,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      left: focus.x * pixelSize,
                      top: focus.y * pixelSize,
                      child: Visibility(
                        visible: focus.isFocus,
                        child: SizedBox(
                          height: pixelSize,
                          width: pixelSize,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                                strokeAlign: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
