import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/providers/booking_page_provider.dart';
import 'package:myecl/booking/tools/constants.dart';

class Button extends ConsumerWidget {
  final String text;
  final BookingPage page;
  const Button({Key? key, required this.text, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(bookingPageProvider.notifier);
    return GestureDetector(
      onTap: (() {
        pageNotifier.setBookingPage(page);
      }),
      child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: BookingColorConstants.darkBlue,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: BookingColorConstants.softBlack,
                  offset: const Offset(2, 3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
