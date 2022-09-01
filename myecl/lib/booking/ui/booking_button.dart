import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

class BookingButton extends ConsumerWidget {
  final Booking res;
  final Color color;
  final Decision state;
  const BookingButton(
      {Key? key, required this.res, required this.color, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool checked = res.decision == state;
    final listResNotifier = ref.watch(bookingListProvider.notifier);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
              color: checked ? color.withOpacity(0.3) : Colors.transparent,
              offset: const Offset(2, 3),
              blurRadius: 5)
        ],
        color: checked ? color : Colors.transparent,
      ),
      child: IconButton(
        onPressed: () async {
          tokenExpireWrapper(ref, () async {
            await listResNotifier.toggleConfirmed(res, state);
          });
        },
        icon: FaIcon(
          state == Decision.approved
              ? FontAwesomeIcons.check
              : FontAwesomeIcons.xmark,
          color: checked ? Colors.white : color,
        ),
      ),
    );
  }
}
