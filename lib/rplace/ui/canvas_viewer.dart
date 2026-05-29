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
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final transformationController = useMemoized(
      () => TransformationController(),
    );
    useEffect(() => transformationController.dispose, []);

    return AsyncChild(
      value: gridInfo,
      builder: (context, gridInfo) {
        final int nbLigne = gridInfo.nbLigne;
        final int nbColonne = gridInfo.nbColonne;
        final double pixelSize = gridInfo.pixelSize;
        final Duration cooldown = gridInfo.cooldown;

        if (nbLigne <= 0 || nbColonne <= 0 || pixelSize <= 0) {
          return const Center(child: Text("Invalid canvas dimensions"));
        }

        final double canvasWidth = pixelSize * nbColonne;
        final double canvasHeight = pixelSize * nbLigne;

        return GestureDetector(
          onTapUp: (event) {
            final Offset canvasPos = transformationController.toScene(
              event.localPosition,
            );
            final int x = canvasPos.dx ~/ pixelSize;
            final int y = canvasPos.dy ~/ pixelSize;

            if (x < 0 || x >= nbColonne || y < 0 || y >= nbLigne) return;

            pixelinfo.getPixelInfo(x, y);
            focusNotifier.setPixelFocus(PixelFocus(x: x, y: y, isFocus: true));

            WidgetsBinding.instance.addPostFrameCallback((_) {
              showModalBottomSheet(
                barrierColor: const Color.fromARGB(50, 0, 0, 0),
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
              ).then((_) => focusNotifier.unfocus());
            });
          },
          child: InteractiveViewer(
            transformationController: transformationController,
            constrained: false,
            minScale: 0.1,
            maxScale: 15,
            boundaryMargin: EdgeInsets.all(double.infinity),
            child: Stack(
              children: [
                Container(
                  width: canvasWidth,
                  height: canvasHeight,
                  color: const Color(0xFFC4C4C4),
                ),
                AsyncChild(
                  value: pixels,
                  builder: (context, pixels) {
                    return CustomPaint(
                      size: Size(canvasWidth, canvasHeight),
                      painter: MyPainter(pixels: pixels, pixelSize: pixelSize),
                    );
                  },
                ),
                if (focus.isFocus)
                  CustomPaint(
                    size: Size(canvasWidth, canvasHeight),
                    painter: FocusPainter(
                      pixelSize: pixelSize,
                      x: focus.x,
                      y: focus.y,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
      errorBuilder: (error, stackTrace) {
        return Center(child: Text("Error loading canvas: $error"));
      },
      loadingBuilder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
