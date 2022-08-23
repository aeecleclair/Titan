import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/booking/ui/booking_ui.dart';
import 'package:myecl/booking/ui/refresh_indicator.dart';

class ListBooking extends ConsumerWidget {
  final bool isAdmin;
  const ListBooking({Key? key, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(bookingListProvider);
    return Expanded(
        child: BookingRefresher(
      onRefresh: () async {
        await ref.watch(bookingListProvider.notifier).loadBookings();
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: bookings.when(
            data: (listBooking) {
              if (listBooking.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 150,
                  child: const Center(
                    child: Text(BookingTextConstants.noCurrentBooking),
                  ),
                );
              }
              return Column(
                children: listBooking
                    .map((r) => BookingUi(
                          booking: r,
                          isAdmin: isAdmin,
                        ))
                    .toList(),
              );
            },
            loading: () => SizedBox(
                  height: MediaQuery.of(context).size.height - 150,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            error: (e, s) => SizedBox(
                  height: MediaQuery.of(context).size.height - 150,
                  child: Center(child: Text(e.toString())),
                )),
      ),
    ));
  }
}
