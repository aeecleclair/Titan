import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/raffle/providers/user_amount_provider.dart';
import 'package:myecl/raffle/providers/prize_list_provider.dart';
import 'package:myecl/raffle/providers/raffle_provider.dart';
import 'package:myecl/raffle/providers/type_ticket_provider.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/raffle/ui/pages/raffle_page/buy_type_ticket_card.dart';
import 'package:myecl/raffle/ui/pages/raffle_page/prize_card.dart';
import 'package:myecl/raffle/ui/raffle.dart';
import 'package:myecl/tools/ui/refresher.dart';

class RaffleInfoPage extends HookConsumerWidget {
  const RaffleInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(idProvider);
    final raffle = ref.watch(raffleProvider);
    final balance = ref.watch(userAmountProvider);
    final balanceNotifier = ref.read(userAmountProvider.notifier);
    final typeTicketList = ref.watch(typeTicketsListProvider);
    final typeTicketListNotifier = ref.read(typeTicketsListProvider.notifier);
    final prizeList = ref.watch(prizeListProvider);
    final prizeListNotifier = ref.read(prizeListProvider.notifier);

    return RaffleTemplate(
      child: Refresher(
        onRefresh: () async {
          userId.whenData(
              (value) async => await balanceNotifier.loadCashByUser(value));
          await typeTicketListNotifier.loadTypeTicketSimpleList();
          await prizeListNotifier.loadPrizeList();
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.only(left: 30, top: 20),
            child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const RadialGradient(
                      colors: [
                        RaffleColorConstants.gradient1,
                        RaffleColorConstants.gradient2
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
                  balance.when(
                      data: (s) =>
                          "Solde : ${s.balance.toStringAsFixed(2)}€", //Attention là c'est les soldes AMAP à finir
                      error: (e, s) => "Erreur",
                      loading: () => "Loading"),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: RaffleColorConstants.gradient2))),
          typeTicketList.when(
              data: (typeTickets) {
                return SizedBox(
                    height: 190,
                    child: typeTickets.isEmpty
                        ? Container(
                            height: 190,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child:
                                const Text(RaffleTextConstants.noTicketBuyable),
                          )
                        : ListView.builder(
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
                                  child: BuyTypeTicketSimple(
                                      typeTicket: typeTickets[index - 1],
                                      raffle: raffle));
                            }));
              },
              loading: () => Container(
                  height: 190,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  )),
              error: (error, stack) => Container(
                    height: 190,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text('Error $error'),
                  )),
          prizeList.when(
              data: (prizes) {
                prizes = prizes
                    .where((element) => element.raffleId == raffle.id)
                    .toList();
                return prizes.isEmpty
                    ? Container(
                        height: 120,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(RaffleTextConstants.actualPrize,
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: RaffleColorConstants.gradient2,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(RaffleTextConstants.noPrize),
                            ]))
                    : Column(children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    prizes.isEmpty
                                        ? RaffleTextConstants.noPrize
                                        : RaffleTextConstants.actualPrize,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: RaffleColorConstants.gradient2,
                                        fontWeight: FontWeight.bold)))),
                        SizedBox(
                            height: 120,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: prizes.length + 2,
                                itemBuilder: (context, index) {
                                  if (index == 0 || index == prizes.length + 1) {
                                    return const SizedBox(
                                      width: 20,
                                    );
                                  }
                                  return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      child: PrizeCard(
                                        prize: prizes[index - 1],
                                      ));
                                }))
                      ]);
              },
              loading: () => Container(
                  height: 120,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(RaffleTextConstants.actualPrize,
                            style: TextStyle(
                                fontSize: 25,
                                color: RaffleColorConstants.gradient2,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        )
                      ])),
              error: (error, stack) => Container(
                  height: 120,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(RaffleTextConstants.actualPrize,
                            style: TextStyle(
                                fontSize: 25,
                                color: RaffleColorConstants.gradient2,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Error $error'),
                      ]))),
          if (raffle.description != null)
            Container(
              padding:
                  const EdgeInsets.only(top: 20, bottom: 10, left: 30, right: 30),
              child: const Text("Description",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: RaffleColorConstants.gradient2)),
            ),
          Container(
              padding:
                  const EdgeInsets.only(top: 20, bottom: 10, left: 30, right: 30),
              child: Text(raffle.description ?? "",
                  style: const TextStyle(fontSize: 15))),
        ]),
      ),
    );
  }
}
