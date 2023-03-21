// // From https://thomasgallinari.medium.com/remove-a-color-from-an-image-in-flutter-36770ac42669

// import 'dart:async';
// import 'dart:ui';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as External;

// class _ColoringKey {
//   final Object providerCacheKey;

//   const _ColoringKey(this.providerCacheKey);

//   @override
//   bool operator ==(Object other) {
//     if (other.runtimeType != runtimeType) return false;
//     return other is _ColoringKey && other.providerCacheKey == providerCacheKey;
//   }

//   @override
//   int get hashCode => providerCacheKey.hashCode;
// }

// class RecoloringImageProvider extends ImageProvider<_ColoringKey> {
//   final ImageProvider imageProvider;

//   const RecoloringImageProvider(this.imageProvider);

//   @override
//   ImageStreamCompleter load(_ColoringKey key, DecoderCallback decode) {
//       Future<Future<Codec>> coloringDecoder(Uint8List bytes,
//         {bool? allowUpscaling, int? cacheWidth, int? cacheHeight}) async {
//           return decode(await recoloring(bytes),
//           allowUpscaling: allowUpscaling ?? false,
//           cacheWidth: cacheWidth,
//         cacheHeight: cacheHeight);
//         }
//     return imageProvider.loadBuffer(key.providerCacheKey, coloringDecoder);
//   }

//   @override
//   Future<_ColoringKey> obtainKey(ImageConfiguration configuration) {
//     Completer<_ColoringKey>? completer;
//     SynchronousFuture<_ColoringKey>? syncCompleter;
//     imageProvider.obtainKey(configuration).then((Object key) {
//       if (completer != null) {
//         completer.complete(_ColoringKey(key));
//       } else {
//         syncCompleter = SynchronousFuture<_ColoringKey>(_ColoringKey(key));
//       }
//     });
//     if (syncCompleter != null) {
//       return syncCompleter!;
//     }
//     completer = Completer<_ColoringKey>();
//     return completer.future;
//   }

//   Future<Uint8List> recoloring(Uint8List bytes) async {
//     final image = External.decodeImage(bytes);
//     final pixels = image!.getBytes(order: External.ChannelOrder.rgba);
//     final length = pixels.lengthInBytes;
//     for (var i = 0; i < length; i += 4) {
//       final r = pixels[i];
//       final g = pixels[i + 1];
//       final b = pixels[i + 2];
//       final a = pixels[i + 3];
//       if (r == 0 && g == 0 && b == 0) {
//         pixels[i] = 0;
//         pixels[i + 1] = 0;
//         pixels[i + 2] = 0;
//         pixels[i + 3] = 0;
//       }
//     }
//     return External.encodePng(image);
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as External;

class ImageColorSwitcher extends StatelessWidget {

  /// Holds the Image in Byte Format
  final Uint8List imageBytes;
  

  /// Holds the MaterialColor
  final MaterialColor color;

  const ImageColorSwitcher({super.key, required this.imageBytes, required this.color});


  /// A function that switches the image color.
  Future<Uint8List> switchColor(Uint8List bytes) async {
    // Decode the bytes to [Image] type
    final image = External.decodeImage(bytes);

    // Convert the [Image] to RGBA formatted pixels
    final pixels = image!.getBytes(order: External.ChannelOrder.rgba);

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

      // Detect the light blue color & switch it with the desired color's RGB value.
      if (pixels[i] == 252 && pixels[i + 1] == 236 && pixels[i + 2] == 60) {
        pixels[i] = color.shade300.red;
        pixels[i + 1] = color.shade300.green;
        pixels[i + 2] = color.shade300.blue;
      }

      // Detect the darkish blue shade & switch it with the desired color's RGB value.
      else if (pixels[i] == 252 && pixels[i + 1] == 156 && pixels[i + 2] == 4) {
        pixels[i] = color.shade900.red;
        pixels[i + 1] = color.shade900.green;
        pixels[i + 2] = color.shade900.blue;
      }
    }
    return External.encodePng(image);
  }

  @override
  Widget build(BuildContext context) {
    print("ImageColorSwitcher: build() called");
    return FutureBuilder(
      future: switchColor(imageBytes),
      builder: (_, AsyncSnapshot<Uint8List> snapshot) {
        print(snapshot.data);
        return snapshot.hasData && snapshot.data != null
            ? Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.memory(
                  snapshot.data!,
                ).image)),
              )
            : const CircularProgressIndicator();
      },
    );
  }
}
