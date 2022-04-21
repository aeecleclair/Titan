import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/reservation/providers/is_admin_provider.dart';
import 'package:myecl/reservation/providers/reservation_page_provider.dart';
import 'package:myecl/reservation/ui/button.dart';
import 'package:myecl/reservation/ui/calendar.dart';
import 'package:myecl/reservation/ui/form_page.dart';
import 'package:myecl/reservation/ui/list_reservation.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(reservationPageProvider);
    final isAdmin = ref.read(isAdminProvider);
    switch (page) {
      case 0:
        return Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Calendar(),
                const Button(
                  text: "Demande",
                  index: 1,
                ),
                const Button(
                  text: "Historique",
                  index: 2,
                ),
                isAdmin
                    ? const Button(
                        text: "Administration",
                        index: 3,
                      )
                    : Container(),
                const SizedBox()
              ]),
        );
      case 1:
        return const FormPage();
      case 2:
        return const ListReservation(isAdmin: false);
      case 3:
        return const ListReservation(isAdmin: true);
      default:
        return Container();
    }
  }
}
