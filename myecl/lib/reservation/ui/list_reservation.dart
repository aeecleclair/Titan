import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/reservation/providers/list_reservation_provider.dart';
import 'package:myecl/reservation/ui/reservation_ui.dart';

class ListReservation extends ConsumerWidget {
  final bool isAdmin;
  const ListReservation({Key? key, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final res = ref.watch(listReservationProvider);
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: res
              .map((r) => ReservationUi(
                    r: r,
                    isAdmin: false,
                  ))
              .toList(),
        ),
      ),
    );
  }
}