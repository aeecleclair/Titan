import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/providers/raffle_provider.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/providers/type_ticket_provider.dart';

class TombolaWidget extends HookConsumerWidget {
  final Raffle raffle;
  const TombolaWidget({Key? key, required this.raffle}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    final raffleNotifier = ref.watch(raffleProvider.notifier);
    final typeTicketListNotifier = ref.watch(typeTicketsListProvider.notifier);
    return GestureDetector(
        onTap: () {
          raffleNotifier.setRaffle(raffle);
          typeTicketListNotifier.loadTypeTicketList(raffle.id);
          pageNotifier.setTombolaPage(TombolaPage.tombola);
        },
        child: Center(
            child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Image.asset("assets/images/logo.png", height: 80),
            AutoSizeText(
              raffle.name,
              maxLines: 2,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          ]),
        )));
  }
}
