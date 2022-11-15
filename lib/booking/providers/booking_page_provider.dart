import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BookingPage { main, admin, addBooking, addRoom, editRoom, editBooking, detailBookingFromMain, detailBookingFromAdmin }

class BookingPageProvider extends StateNotifier<BookingPage> {
  BookingPageProvider() : super(BookingPage.main);

  void setBookingPage(BookingPage i) {
    state = i;
  }
}

final bookingPageProvider = StateNotifierProvider<BookingPageProvider, BookingPage>((ref) {
  return BookingPageProvider();
});
