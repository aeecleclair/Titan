// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/cinema/providers/cinema_page_provider.dart';

void main() {
  group('CinemaPageProvider', () {
    test('CinemaPageProvider should set the correct page', () {
      final provider = CinemaPageProvider();

      provider.setCinemaPage(CinemaPage.admin);
      expect(provider.state, CinemaPage.admin);

      provider.setCinemaPage(CinemaPage.detailFromMainPage);
      expect(provider.state, CinemaPage.detailFromMainPage);

      provider.setCinemaPage(CinemaPage.addEditSession);
      expect(provider.state, CinemaPage.addEditSession);
    });

    test('cinemaPageProvider should provide the correct initial value', () {
      final container = ProviderContainer();
      final cinemaPage = container.read(cinemaPageProvider);

      expect(cinemaPage, CinemaPage.main);
    });

    test('cinemaPageProvider should update the page correctly', () {
      final container = ProviderContainer();
      final cinemaPage = container.read(cinemaPageProvider.notifier);

      cinemaPage.setCinemaPage(CinemaPage.admin);
      expect(cinemaPage.state, CinemaPage.admin);

      final updatedCinemaPage = container.read(cinemaPageProvider);
      expect(updatedCinemaPage, CinemaPage.admin);
    });
  });
}
