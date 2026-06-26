import 'package:flutter_riverpod/flutter_riverpod.dart';

final displayResult = NotifierProvider<DisplayResult, bool>(DisplayResult.new);

class DisplayResult extends Notifier<bool> {
  @override
  bool build() => false;

  void setId(bool p) {
    state = p;
  }
}
