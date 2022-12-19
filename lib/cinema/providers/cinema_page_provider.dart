import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CinemaPage {
  main,
  admin,
  detailFromMainPage,
  detailFromAdminPage,
  addEditSession,
}

class CinemaPageProvider extends StateNotifier<CinemaPage> {
  CinemaPageProvider() : super(CinemaPage.main);

  void setCinemaPage(CinemaPage i) {
    state = i;
  }
}

final cinemaPageProvider =
    StateNotifierProvider<CinemaPageProvider, CinemaPage>((ref) {
  return CinemaPageProvider();
});
