import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingPage extends StateNotifier<int> {
  BookingPage() : super(0);

  void setBookingPage(int i) {
    state = i;
  }
}

final bookingPageProvider = StateNotifierProvider<BookingPage, int>((ref) {
  return BookingPage();
});
