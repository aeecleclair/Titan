import 'package:flutter/material.dart';
import 'package:myecl/rplace/providers/pixelfocus_providers.dart';
import 'package:myecl/rplace/providers/grid_providers.dart';
import 'package:myecl/rplace/ui/color_picker.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'my_painter.dart';
import 'package:myecl/rplace/providers/pixels_providers.dart';
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

    return AsyncChild(
      value: gridInfo,
      builder: (context, gridInfo) {
        final int nbLigne = gridInfo.nbLigne;
        final int nbColonne = gridInfo.nbColonne;
        final double pixelSize = gridInfo.pixelSize;

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
                  focusNotifier.setPixelFocus(
                    PixelFocus(
                      x: ((event.localPosition.dx) ~/ pixelSize) * pixelSize,
                      y: ((event.localPosition.dy) ~/ pixelSize) * pixelSize,
                      user: "",
                      date: DateTime.now(),
                      isFocus: true,
                    ),
                  );
                  Future<void> future = showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ColorPicker(
                        x: (((event.localPosition.dx) ~/ pixelSize) *
                                pixelSize +
                            5),
                        y: (((event.localPosition.dy) ~/ pixelSize) *
                                pixelSize +
                            5),
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
                      left: focus.x,
                      top: focus.y,
                      child: Visibility(
                        visible: focus.isFocus,
                        child: SizedBox(
                          height: pixelSize,
                          width: pixelSize,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.amber),
                            ),
                          ),
                        ),
                      ),
                    )
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
