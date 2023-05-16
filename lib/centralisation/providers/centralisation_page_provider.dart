import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CentralisationPage {
  main
}

final centralisationPageProvider = 
  StateNotifierProvider<CentralisationPageNotifier, CentralisationPage>((ref) {
  return CentralisationPageNotifier();
});

class CentralisationPageNotifier extends StateNotifier<CentralisationPage> {
  CentralisationPageNotifier() : super(CentralisationPage.main);

  void setCentralisationPage(CentralisationPage i) {
    state = i;
  }
}


