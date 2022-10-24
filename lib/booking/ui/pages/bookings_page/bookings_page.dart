import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/providers/user_booking_list_provider.dart';
import 'package:myecl/booking/ui/booking_list.dart';
import 'package:myecl/booking/ui/refresh_indicator.dart';

class BookingsPage extends HookConsumerWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsNotifier = ref.watch(userBookingListProvider.notifier);
    return SizedBox(
      height: MediaQuery.of(context).size.height - 117,
      child: BookingRefresher(
          onRefresh: () async {
            await bookingsNotifier.loadUserBookings();
          },
          child: const ListBooking(
            isAdmin: false,
          )),
    );
  }
}
