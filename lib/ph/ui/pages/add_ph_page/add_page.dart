import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/providers/ph_provider.dart';
import 'package:myecl/ph/ui/button.dart';

class PdfPicker extends HookConsumerWidget {
  const PdfPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = useState<FilePickerResult?>(null);
    final ph = ref.watch(phProvider.notifier);
    return SizedBox(
      height: 40,
      child: GestureDetector(
          onTap: () async {
            result.value = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );
            if (result.value == null) {
              print("No file selected");
            } else {
              ph.createPh(result.value);
            }
          },
          child: const MyButton(
            text: "Ajouter un journal",
          )),
    );
  }
}
