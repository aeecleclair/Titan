import 'package:flutter_riverpod/flutter_riverpod.dart';


final editionProvider = StateNotifierProvider<EditionProvider, bool>((ref) {
  return EditionProvider();
});

class EditionProvider extends StateNotifier<bool> {
  EditionProvider() : super(false);

  void setStatus(bool i) {
    state = i;
  }
}