import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/providers/ph_send_pdf_provider.dart';
import 'package:myecl/ph/ui/button.dart';

class PdfPicker extends HookConsumerWidget {
  final bool isEdit;
  const PdfPicker({super.key, required this.isEdit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testNotifier = ref.watch(phSendPdfProvider.notifier);
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
          child: MyButton(
            text: isEdit ? "Modifier le fichier" : "Ajouter un fichier PDF",
          )),
    );
  }
}
