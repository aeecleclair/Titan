import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/reservation/class/res.dart';
import 'package:myecl/reservation/ui/reservation_button.dart';

class ReservationUi extends ConsumerWidget {
  final Reservation r;
  final bool isAdmin;
  const ReservationUi({Key? key, required this.r, required this.isAdmin})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 95,
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(2, 3),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    r.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 1, 49, 68),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    r.date,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 2, 84, 104),
                    ),
                  ),
                ],
              ),
            ),
            isAdmin
                ? SizedBox(
                    width: 115,
                    child: Row(
                      children: [
                        ReservationButton(
                            res: r,
                            color: const Color.fromARGB(255, 1, 49, 68),
                            state: 2),
                        const SizedBox(
                          width: 5,
                        ),
                        ReservationButton(
                            res: r,
                            color: const Color.fromARGB(255, 9, 106, 130),
                            state: 1)
                      ],
                    ),
                  )
                : Container(
                    width: 100,
                    alignment: Alignment.center,
                    child: Text(
                      r.state == 0
                          ? "En attente"
                          : r.state == 1
                              ? "Validée"
                              : "Refusée",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: r.state == 2
                            ? const Color.fromARGB(255, 1, 49, 68)
                            : r.state == 1
                                ? const Color.fromARGB(255, 9, 106, 130)
                                : const Color.fromARGB(255, 63, 120, 134),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
