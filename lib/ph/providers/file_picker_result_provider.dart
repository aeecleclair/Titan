import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilePickerResultNotifier extends Notifier<PlatformFile?> {
  @override
  PlatformFile? build() {
    return null;
  }

  void setFilePickerResult(PlatformFile? bytes) {
    state = bytes;
  }
}

final filePickerResultProvider =
    NotifierProvider<FilePickerResultNotifier, PlatformFile?>(
      FilePickerResultNotifier.new,
    );
