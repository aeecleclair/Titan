import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:myecl/amap/providers/user_amount_provider.dart';

import 'package:myecl/tombola/providers/lot_list_provider.dart';
import 'package:myecl/tombola/providers/raffle_provider.dart';
import 'package:myecl/tombola/providers/type_ticket_provider.dart';
import 'package:myecl/tombola/providers/user_tickets_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/pages/tombola_page/buy_type_ticket_card.dart';
import 'package:myecl/tombola/ui/pages/tombola_page/prize_card.dart';

class TombolaInfoPage extends HookConsumerWidget {
  const TombolaInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffle = ref.watch(raffleProvider);
    final userTicketList = ref.watch(userTicketListProvider);
    final solde = ref.watch(userAmountProvider);
    final typeTicketList = ref.watch(typeTicketsListProvider);
    final lotsList = ref.watch(lotListProvider);

    return Container(
        margin: const EdgeInsets.only(top: 20),
        child: ListView(children: [
          Center(
              child: Text(raffle.name,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold))),
          Container(
              margin: const EdgeInsets.only(left: 10, top: 20),
              child: Text(
                  solde.when(
                      data: (s) =>
                          "Solde : ${s.balance.toStringAsFixed(2)}€", //Attention là c'est les soldes AMAP à finir
                      error: (e, s) => "Erreur",
                      loading: () => "Loading"),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))),
          typeTicketList.when(
              data: (type_tickets) {
                return type_tickets.isEmpty
                    ? const Center(
                        child: Text(TombolaTextConstants.noTicketBuyable),
                      )
                    : SizedBox(
                        height: 210,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: type_tickets.length + 2,
                            itemBuilder: (context, index) {
                              if (index == 0 ||
                                  index == type_tickets.length + 1) {
                                return const SizedBox(
                                  width: 15,
                                );
                              }
                              return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: BuyTypeTicket(
                                      type_ticket: type_tickets[index - 1],
                                      raffle: raffle));
                            }));
              },
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
              error: (error, stack) => const Center(
                    child: Text('Error'),
                  )),
          lotsList.when(
              data: (lots) {
                return lots.isEmpty
                    ? const Center(
                        child: Text(TombolaTextConstants.noPrize),
                      )
                    : Column(children: [
                        Container(
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 20, right: 20),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    lots.isEmpty
                                        ? TombolaTextConstants.noPrize
                                        : TombolaTextConstants.actualPrize,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)))),
                        SizedBox(
                            height: 120,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: lots.length + 2,
                                itemBuilder: (context, index) {
                                  if (index == 0 || index == lots.length + 1) {
                                    return const SizedBox(
                                      width: 15,
                                    );
                                  }
                                  return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5,vertical: 10),
                                      child: PrizeCard(
                                        prize: lots[index - 1],
                                      ));
                                }))
                      ]);
              },
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
              error: (error, stack) => const Center(
                    child: Text('Error'),
                  )),
          if (raffle.description != null)
            Container(
              padding:
                  EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
              child: Text("Description",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
          Container(
              padding:
                  EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
              child: Text(raffle.description ?? "",
                  style: TextStyle(fontSize: 15))),
        ]));
    //   const Positioned(
    //     bottom: 10,
    //     right: 10,
    //     child: PersoButton(text: "Modifiez votre tombola [SI CREATEUR]"),
    //   )
    // ]);
  }
}
