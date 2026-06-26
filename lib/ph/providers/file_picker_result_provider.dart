import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilePickerResultNotifier extends Notifier<FilePickerResult?> {
  @override
  FilePickerResult? build() {
    return null;
  }

  void setFilePickerResult(FilePickerResult? bytes) {
    state = bytes;
  }
}

final filePickerResultProvider =
    NotifierProvider<FilePickerResultNotifier, FilePickerResult?>(
      FilePickerResultNotifier.new,
    );
