import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as external_image;

class BirdImageNotifier extends StateNotifier<Uint8List> {
  BirdImageNotifier() : super(Uint8List.fromList([]));

  void setList(Uint8List list) {
    state = list;
  }

  Future<void> getBirdImage() async {
    final image = await rootBundle.load("assets/images/bird.png");
    external_image.Image? img = external_image.decodeImage(
      image.buffer.asUint8List(),
    );
    external_image.Image resized = external_image.copyResize(img!, width: 50);
    state = Uint8List.fromList(external_image.encodePng(resized));
  }

  Future<Uint8List> switchColor(MaterialColor color) async {
    // Decode the bytes to [Image] type
    final image = external_image.decodeImage(state);

    // Convert the [Image] to RGBA formatted pixels
    final pixels = image!.getBytes(order: external_image.ChannelOrder.rgba);

    // Get the Pixel Length
    final int length = pixels.lengthInBytes;

    for (var i = 0; i < length; i += 4) {
      ///           PIXELS
      /// =============================
      /// | i | i + 1 | i + 2 | i + 3 |
      /// =============================

      // pixels[i] represents Red
      // pixels[i + 1] represents Green
      // pixels[i + 2] represents Blue
      // pixels[i + 3] represents Alpha
      if (pixels[i] >= 250 && pixels[i + 1] >= 250 && pixels[i + 2] >= 250) {
        continue;
      }
      // Detect the light blue color & switch it with the desired color's RGB value.
      else if (pixels[i] >= 250 &&
          pixels[i + 1] >= 230 &&
          pixels[i + 2] >= 50) {
        pixels[i] = (color.shade300.r * 255).round();
        pixels[i + 1] = (color.shade300.g * 255).round();
        pixels[i + 2] = (color.shade300.b * 255).round();
      }
      // Detect the darkish blue shade & switch it with the desired color's RGB value.
      else if (pixels[i] >= 200 && pixels[i + 1] >= 100 && pixels[i + 2] >= 0) {
        pixels[i] = (color.shade300.r * 255).round();
        pixels[i + 1] = (color.shade300.g * 255).round();
        pixels[i + 2] = (color.shade300.b * 255).round();
      }
    }
    return external_image.encodePng(image);
  }
}

final birdImageProvider = StateNotifierProvider<BirdImageNotifier, Uint8List>((
  ref,
) {
  BirdImageNotifier notifier = BirdImageNotifier();
  notifier.getBirdImage();
  return notifier;
});
