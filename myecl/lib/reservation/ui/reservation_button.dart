import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myecl/reservation/class/res.dart';
import 'package:myecl/reservation/providers/list_reservation_provider.dart';

class ReservationButton extends ConsumerWidget {
  final Reservation res;
  final Color color;
  final int state;
  const ReservationButton(
      {Key? key, required this.res, required this.color, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool checked = res.state == state;
    final listResNotifier = ref.watch(listReservationProvider.notifier);
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
        onPressed: () {
          listResNotifier.changeState(res, state);
        },
        icon: FaIcon(
          state == 1 ? FontAwesomeIcons.check : FontAwesomeIcons.xmark,
          color: checked ? Colors.white : color,
        ),
      ),
    );
  }
}
