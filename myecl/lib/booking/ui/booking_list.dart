import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/ui/booking_ui.dart';

class ListBooking extends ConsumerWidget {
  final bool isAdmin;
  const ListBooking({Key? key, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final res = ref.watch(bookingListProvider);
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: res
              .map((r) => BookingUi(
                    r: r,
                    isAdmin: isAdmin,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
