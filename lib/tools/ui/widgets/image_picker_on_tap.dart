import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';

class ImagePickerOnTap extends StatelessWidget {
  final ImagePicker picker;
  final ValueNotifier<Uint8List?> imageBytesNotifier;
  final ValueNotifier<Image?> imageNotifier;
  final void Function(TypeMsg, String) displayToastWithContext;
  final Widget child;
  final int? imageQuality;

  const ImagePickerOnTap({
    super.key,
    required this.picker,
    required this.imageBytesNotifier,
    required this.imageNotifier,
    required this.displayToastWithContext,
    required this.child,
    this.imageQuality,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final crossFile = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: imageQuality,
        );
        if (crossFile != null) {
          final size = await crossFile.length();
          if (size > maxHyperionFileSize) {
            displayToastWithContext(
              TypeMsg.error,
              AppLocalizations.of(context)!.othersImageSizeTooBig,
            );
          } else {
            if (kIsWeb) {
              imageBytesNotifier.value = await crossFile.readAsBytes();
              imageNotifier.value = Image.network(crossFile.path);
            } else {
              final file = File(crossFile.path);
              imageBytesNotifier.value = await file.readAsBytes();
              imageNotifier.value = Image.file(file);
            }
          }
        }
      },
      child: child,
    );
  }
}
