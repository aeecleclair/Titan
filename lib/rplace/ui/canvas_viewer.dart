import 'package:flutter/material.dart';
import 'package:titan/rplace/providers/pixelfocus_providers.dart';
import 'package:titan/rplace/providers/grid_providers.dart';
import 'package:titan/rplace/providers/pixelinfo_providers.dart';
import 'package:titan/rplace/ui/color_picker.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'my_painter.dart';
import 'package:titan/rplace/providers/pixels_providers.dart';
import 'package:titan/rplace/providers/userinfo_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/rplace/class/focus.dart';
import 'package:titan/rplace/ui/cooldown.dart';

class CanvasViewer extends HookConsumerWidget {
  const CanvasViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    timeago.setDefaultLocale('fr');
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

        // Add validation
        if (nbLigne <= 0 || nbColonne <= 0 || pixelSize <= 0) {
          return Center(child: Text("Invalid canvas dimensions"));
        }

        final double canvasWidth = pixelSize * nbColonne;
        final double canvasHeight = pixelSize * nbLigne;

        return InteractiveViewer(
          constrained: false,
          minScale: 0.1,
          maxScale: 15,

          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(16.0),
            // color:
            //     Colors.grey[300], // Add background color to see the container
            child: Center(
              child: GestureDetector(
                onTapDown: (event) {
                  final int x = (event.localPosition.dx) ~/ pixelSize;
                  final int y = (event.localPosition.dy) ~/ pixelSize;

                  //Check if outside grid
                  if (x < 0 || x >= nbColonne || y < 0 || y >= nbLigne) {
                    return;
                  }

                  pixelinfo.getPixelInfo(x, y);
                  focusNotifier.setPixelFocus(
                    PixelFocus(x: x, y: y, isFocus: true),
                  );
                  showModalBottomSheet(
                    barrierColor: Color.fromARGB(50, 0, 0, 0),
                    context: context,
                    builder: (BuildContext context) {
                      return AsyncChild(
                        value: userinfo,
                        builder: (context, userinfo) {
                          final timeDiff = DateTime.now().difference(
                            userinfo.lastplaced,
                          );
                          if (timeDiff < cooldown) {
                            return CooldownWidget(
                              userinfo: userinfo,
                              cooldown: cooldown - timeDiff,
                            );
                          } else {
                            return ColorPicker(x: x, y: y);
                          }
                        },
                      );
                    },
                  ).then((value) => focusNotifier.unfocus());
                },
                child: Container(
                  width: canvasWidth,
                  height: canvasHeight,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: Expanded(
                    child: Stack(
                      children: [
                        Container(
                          width: canvasWidth,
                          height: canvasHeight,
                          color: Color(0xFFC4C4C4),
                        ),
                        AsyncChild(
                          value: pixels,
                          builder: (context, pixels) {
                            print("Rendering ${pixels.length} pixels");
                            return CustomPaint(
                              size: Size(canvasWidth, canvasHeight),
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
                            child: Container(
                              height: pixelSize,
                              width: pixelSize,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
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
            ),
          ),
        );
      },
      // Add error handling
      errorBuilder: (error, stackTrace) {
        print("Error loading grid: $error");
        return Center(child: Text("Error loading canvas: $error"));
      },
      loadingBuilder: (context) {
        print("Loading grid...");
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
