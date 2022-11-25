import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/providers/booking_provider.dart';
import 'package:myecl/booking/tools/functions.dart';
import 'package:myecl/booking/ui/booking_card.dart';

class DetailBookingPage extends HookConsumerWidget {
  const DetailBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingProvider);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade50,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Container(
                        padding: const EdgeInsets.all(30.0),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              decisionToString(booking.decision),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              booking.note,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: BookingCard(
                  booking: booking,
                  onEdit: () {},
                  onReturn: () {},
                  onInfo: () {},
                  isAdmin: false,
                  isDetail: true),
            ),
          )
        ],
      ),
    );
    // return Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 30.0),
    //     child: Column(children: [
    //       const SizedBox(
    //         height: 40,
    //       ),
    //       Text(
    //         capitalize(booking.room.name),
    //         style: const TextStyle(
    //           fontSize: 35,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Text(
    //         formatDates(booking.start, booking.end, false),
    //         style: const TextStyle(
    //           fontSize: 18,
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 15,
    //       ),
    //       Text(
    //         decisionToString(booking.decision),
    //         style: const TextStyle(
    //           fontSize: 30,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 15,
    //       ),
    //       Text(
    //         booking.key
    //             ? BookingTextConstants.keys
    //             : BookingTextConstants.noKeys,
    //         style: const TextStyle(
    //           fontSize: 20,
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 30,
    //       ),
    //       Text(
    //         booking.note,
    //         style: const TextStyle(
    //           fontSize: 18,
    //         ),
    //       ),
    //     ]));
  }
}
