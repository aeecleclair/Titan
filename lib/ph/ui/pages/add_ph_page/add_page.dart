import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/providers/ph_pdf_test_provider.dart';
import 'package:myecl/ph/ui/button.dart';

class PdfPicker extends HookConsumerWidget {
  const PdfPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testNotifier = ref.watch(phTestProvider.notifier);
    final result = useState<FilePickerResult?>(null);
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
              testNotifier.set(result.value!.files.single.bytes!);
            }
          },
          child: const MyButton(
            text: "Ajouter un fichier PDF",
          )),
    );
  }
}
