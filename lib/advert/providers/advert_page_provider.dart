import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AdvertPage {
  main,
  admin,
  detailFromMainPage,
  detailFromAdminPage,
  addEditAdvert,
  addRemAnnouncer,
}

final advertPageProvider =
    StateNotifierProvider<AdvertPageNotifier, AdvertPage>((ref) {
  return AdvertPageNotifier();
});

class AdvertPageNotifier extends StateNotifier<AdvertPage> {
  AdvertPageNotifier() : super(AdvertPage.main);

  void setAdvertPage(AdvertPage i) {
    state = i;
  }
}
