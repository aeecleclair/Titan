import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/widgets/image_picker_on_tap.dart';

class MyCMMTab extends HookWidget {
  const MyCMMTab({super.key});

  @override
  Widget build(BuildContext context) {
    final poster = useState<Uint8List?>(null);
    final posterFile = useState<Image?>(null);
    final ImagePicker picker = ImagePicker();

    void displayAdvertToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return FormField<File>(
      validator: (e) {
        if (poster.value == null) {
          return "Choix poster";
        }
        return null;
      },
      builder: (formFieldState) => Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ImagePickerOnTap(
              picker: picker,
              imageBytesNotifier: poster,
              imageNotifier: posterFile,
              displayToastWithContext: displayAdvertToastWithContext,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: formFieldState.hasError
                          ? Colors.red
                          : Colors.black.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(2, 3),
                    ),
                  ],
                ),
                child: posterFile.value != null
                    ? Stack(
                        children: [
                          Container(
                            width: 285,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              image: DecorationImage(
                                image: poster.value != null
                                    ? Image.memory(
                                        poster.value!,
                                        fit: BoxFit.cover,
                                      ).image
                                    : posterFile.value!.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  color: Colors.white.withOpacity(0.4),
                                ),
                                child: HeroIcon(
                                  HeroIcons.photo,
                                  size: 40,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const HeroIcon(
                        HeroIcons.photo,
                        size: 160,
                        color: Colors.grey,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
