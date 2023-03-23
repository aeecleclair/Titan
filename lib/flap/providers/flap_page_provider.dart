import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FlapPage { main, leaderBoard }

class FlapPageNotifier extends StateNotifier<FlapPage> {
  FlapPageNotifier() : super(FlapPage.main);

  void setFlapPage(FlapPage newState) {
    state = newState;
  }
}

final flapPageProvider =
    StateNotifierProvider<FlapPageNotifier, FlapPage>((ref) {
  return FlapPageNotifier();
});
