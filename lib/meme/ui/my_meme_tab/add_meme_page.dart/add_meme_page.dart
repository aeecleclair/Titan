import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/meme/providers/my_meme_list_provider.dart';
import 'package:myecl/meme/ui/meme.dart';
import 'package:myecl/meme/ui/components/button.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/widgets/image_picker_on_tap.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddMemePage extends HookConsumerWidget {
  const AddMemePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poster = useState<Uint8List?>(null);
    final posterFile = useState<Image?>(null);
    final ImagePicker picker = ImagePicker();
    final myMemeListNotifier = ref.watch(myMemeListProvider.notifier);

    void displayAdvertToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return MemeTemplate(
      child: Column(
        children: [
          const Spacer(),
          FormField<File>(
            validator: (e) {
              if (poster.value == null) {
                return MemeTextConstant.choicePoster;
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
                        boxShadow: [
                          BoxShadow(
                            color: formFieldState.hasError
                                ? Colors.red
                                : Colors.black.withValues(alpha: 0.1),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                      child: posterFile.value != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height -
                                            250,
                                    maxWidth: double.infinity, // Max width
                                  ),
                                  child: Image.memory(poster.value!),
                                ),
                              ),
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
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              myMemeListNotifier.addMeme(poster.value!);
              QR.back();
            },
            child: const MyButton(
              text: MemeTextConstant.addThisMeme,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
