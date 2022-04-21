import 'package:flutter_riverpod/flutter_riverpod.dart';

final amapPageProvider = StateNotifierProvider<AmapPage, int>((ref) {
  return AmapPage();
});

class AmapPage extends StateNotifier<int> {
  AmapPage() : super(0);

  void setAmapPage(int i) {
    state = i;
  }
}
