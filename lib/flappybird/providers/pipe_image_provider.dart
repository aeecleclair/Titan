import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as external_image;

class PipeImageNotifier extends StateNotifier<Uint8List> {
  PipeImageNotifier() : super(Uint8List.fromList([]));

  void setList(Uint8List list) {
    state = list;
  }

  Future<void> getPipeImage() async {
    final image = await rootBundle.load("assets/images/pipe.png");
    external_image.Image? img = external_image.decodeImage(
      image.buffer.asUint8List(),
    );
    external_image.Image resized = external_image.copyResize(img!, width: 80);
    state = Uint8List.fromList(external_image.encodePng(resized));
  }
}

final pipeImageProvider = StateNotifierProvider<PipeImageNotifier, Uint8List>((
  ref,
) {
  PipeImageNotifier notifier = PipeImageNotifier();
  notifier.getPipeImage();
  return notifier;
});
