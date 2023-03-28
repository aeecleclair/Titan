import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tombola/providers/user_amount_provider.dart';
import 'package:myecl/tombola/providers/lot_list_provider.dart';
import 'package:myecl/tombola/providers/raffle_provider.dart';
import 'package:myecl/tombola/providers/type_ticket_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/pages/tombola_page/buy_type_ticket_card.dart';
import 'package:myecl/tombola/ui/pages/tombola_page/prize_card.dart';

class TombolaInfoPage extends HookConsumerWidget {
  const TombolaInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffle = ref.watch(raffleProvider);
    final solde = ref.watch(userAmountProvider);
    final typeTicketList = ref.watch(typeTicketsListProvider);
    final lotsList = ref.watch(lotListProvider);

    return ListView(children: [
      Container(
        margin: const EdgeInsets.only(left: 30, top: 20),
        child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => const RadialGradient(
                  colors: [
                    TombolaColorConstants.gradient1,
                    TombolaColorConstants.gradient2
                  ],
                  radius: 6.0,
                  tileMode: TileMode.mirror,
                  center: Alignment.topLeft,
                ).createShader(bounds),
            child: Text(raffle.name,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ))),
      ),
      Container(
          margin: const EdgeInsets.only(left: 30, top: 20),
          child: Text(
            solde.when(
                  data: (s) =>
                      "Solde : ${s.balance.toStringAsFixed(2)}€", //Attention là c'est les soldes AMAP à finir
                  error: (e, s) => "Erreur",
                  loading: () => "Loading"),
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: TombolaColorConstants.gradient2))),
      typeTicketList.when(
          data: (typeTickets) {
            return typeTickets.isEmpty
                ? const Center(
                    child: Text(TombolaTextConstants.noTicketBuyable),
                  )
                : SizedBox(
                    height: 190,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: typeTickets.length + 2,
                        itemBuilder: (context, index) {
                          if (index == 0 || index == typeTickets.length + 1) {
                            return const SizedBox(
                              width: 15,
                            );
                          }
                          return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: BuyTypeTicket(
                                  typeTicket: typeTickets[index - 1],
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
            lots = lots.where((element) => element.raffleId == raffle.id).toList();
            return lots.isEmpty
                ? const Center(
                    child: Text(TombolaTextConstants.noPrize),
                  )
                : Column(children: [
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                lots.isEmpty
                                    ? TombolaTextConstants.noPrize
                                    : TombolaTextConstants.actualPrize,
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: TombolaColorConstants.gradient2,
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
                                  width: 20,
                                );
                              }
                              return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
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
              const EdgeInsets.only(top: 20, bottom: 10, left: 30, right: 30),
          child: const Text("Description",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: TombolaColorConstants.gradient2)),
        ),
      Container(
          padding:
              const EdgeInsets.only(top: 20, bottom: 10, left: 30, right: 30),
          child: Text(raffle.description ?? "",
              style: const TextStyle(fontSize: 15))),
    ]);
  }
}
