import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilePickerResultNotifier extends StateNotifier<FilePickerResult?> {
  FilePickerResultNotifier() : super(null);

  void setFilePickerResult(FilePickerResult? bytes) {
    state = bytes;
  }
}

final filePickerResultProvider =
    StateNotifierProvider<FilePickerResultNotifier, FilePickerResult?>((ref) {
      return FilePickerResultNotifier();
    });
