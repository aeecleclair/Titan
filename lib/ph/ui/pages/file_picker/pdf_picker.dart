import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ph/providers/edit_pdf_provider.dart';
import 'package:titan/ph/providers/file_picker_result_provider.dart';
import 'package:titan/ph/providers/ph_send_pdf_provider.dart';
import 'package:titan/ph/tools/constants.dart';
import 'package:titan/ph/ui/button.dart';
import 'package:titan/tools/functions.dart';

class PdfPicker extends HookConsumerWidget {
  final bool isEdit;
  const PdfPicker({super.key, required this.isEdit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phSendPdfNotifier = ref.watch(phSendPdfProvider.notifier);
    final resultNotifier = ref.watch(filePickerResultProvider.notifier);
    final result = ref.watch(filePickerResultProvider);
    final editPdfNotifier = ref.watch(editPdfProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SizedBox(
      height: 40,
      child: GestureDetector(
        onTap: () async {
          final selectedFile = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: ['pdf'],
          );
          resultNotifier.setFilePickerResult(selectedFile);
          if (selectedFile != null) {
            final Uint8List bytes;
            if (selectedFile.files.single.bytes != null) {
              bytes = selectedFile.files.single.bytes!;
            } else {
              bytes = await File(selectedFile.files.first.path!).readAsBytes();
            }
            if (bytes.length < 10000000) {
              phSendPdfNotifier.set(bytes);
            } else {
              displayToastWithContext(
                TypeMsg.error,
                PhTextConstants.toHeavyFile,
              );
            }
          }
          if (isEdit) {
            editPdfNotifier.editPdf(true);
          }
        },
        child: MyButton(
          text: isEdit
              ? PhTextConstants.editPdfFile
              : (result != null)
              ? result.files.single.name
              : PhTextConstants.addPdfFile,
        ),
      ),
    );
  }
}
