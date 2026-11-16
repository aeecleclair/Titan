import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilePickerResultNotifier extends StateNotifier<PlatformFile?> {
  FilePickerResultNotifier() : super(null);

  void setFilePickerResult(PlatformFile? bytes) {
    state = bytes;
  }
}

final filePickerResultProvider =
    StateNotifierProvider<FilePickerResultNotifier, PlatformFile?>((ref) {
      return FilePickerResultNotifier();
    });
