import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/providers/booking_history_provider.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/ui/booking_ui.dart';

class ListBooking extends ConsumerWidget {
  final bool isAdmin;
  const ListBooking({Key? key, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = isAdmin ? ref.watch(bookingListProvider) : ref.watch(bookingHistoryProvider);
    return bookings.when(
      data: (listBooking) {
        return Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: listBooking
                  .map((r) => BookingUi(
                        booking: r,
                        isAdmin: isAdmin,
                      ))
                  .toList(),
            ),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, s) => const Center(
        child: Text("Pas de réservation en cours"),
      ),
    );
  }
}
