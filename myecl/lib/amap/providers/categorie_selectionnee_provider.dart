import 'package:flutter_riverpod/flutter_riverpod.dart';

final cateSelectionneeProvider =
    StateNotifierProvider.family<CateSelectionnee, String, String>(
  (ref, txt) {
    return CateSelectionnee(txt);
  },
);

class CateSelectionnee extends StateNotifier<String> {
  String txt;
  CateSelectionnee(this.txt) : super(txt);

  void setText(String txt) {
    state = txt;
  }
}
