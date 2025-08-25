import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:titan/tools/constants.dart';

/// Determines if a color is considered dark or light
bool isColorDark(Color color) {
  // Calculate luminance using the standard formula
  final luminance =
      (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
  return luminance < 0.5;
}

/// Gets the appropriate text color based on background color
Color getTextColor(Color backgroundColor) {
  return isColorDark(backgroundColor) ? Colors.white : Colors.black;
}

/// Extracts dominant color from an ImageProvider
Future<Color> getDominantColor(ImageProvider imageProvider) async {
  final completer = Completer<Color>();
  final imageStream = imageProvider.resolve(const ImageConfiguration());

  imageStream.addListener(
    ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) async {
      final image = imageInfo.image;
      final bytes = await image.toByteData(format: ui.ImageByteFormat.rawRgba);

      if (bytes == null) {
        completer.complete(ColorConstants.main);
        return;
      }

      int redSum = 0, greenSum = 0, blueSum = 0;
      int pixelCount = 0;

      // Sample pixels from the bottom portion of the image where text appears
      final int width = image.width;
      final int height = image.height;
      final int startY = (height * 0.6).round(); // Bottom 40% of image

      for (int y = startY; y < height; y += 4) {
        // Sample every 4th pixel for performance
        for (int x = 0; x < width; x += 4) {
          final int pixelIndex = (y * width + x) * 4;
          if (pixelIndex + 2 < bytes.lengthInBytes) {
            redSum += bytes.buffer.asUint8List()[pixelIndex];
            greenSum += bytes.buffer.asUint8List()[pixelIndex + 1];
            blueSum += bytes.buffer.asUint8List()[pixelIndex + 2];
            pixelCount++;
          }
        }
      }

      if (pixelCount > 0) {
        final avgColor = Color.fromRGBO(
          (redSum / pixelCount).round(),
          (greenSum / pixelCount).round(),
          (blueSum / pixelCount).round(),
          1.0,
        );
        completer.complete(avgColor);
      } else {
        completer.complete(ColorConstants.main);
      }
    }),
  );

  return completer.future;
}
