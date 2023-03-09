import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/providers/lot_list_provider.dart';
import 'package:myecl/tombola/providers/raffle_id_provider.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/providers/type_ticket_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';

class TombolaWidget extends HookConsumerWidget {
  final Raffle raffle;
  const TombolaWidget({Key? key, required this.raffle}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    final raffleIdNotifier = ref.watch(raffleIdProvider.notifier);
    final lotListNotifier = ref.read(lotListProvider.notifier);
    final typeTicketListNotifier = ref.watch(typeTicketsListProvider.notifier);
    return GestureDetector(
        onTap: () {
          raffleIdNotifier.setId(raffle.id);
          lotListNotifier.loadLotList();
          typeTicketListNotifier.loadTypeTicketList();
          pageNotifier.setTombolaPage(TombolaPage.detail);
        },
        child: Center(
            child: Container(
          height: 100,
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(105, 193, 193, 193),
                    blurRadius: 6,
                    offset: Offset(2, 3)),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 250, 246, 246),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Image.asset("assets/images/logo.png"),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    raffle.name,
                    style: const TextStyle(
                        color: TombolaColorConstants.darkText, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Lot principal : ",
                    style: TextStyle(
                        color: TombolaColorConstants.darkText, fontSize: 15),
                  ),
                ]),
          ]),
        )));
  }
}
