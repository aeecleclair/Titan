import 'package:auto_size_text/auto_size_text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/raffle_status_type.dart';
import 'package:myecl/tombola/providers/raffle_list_provider.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/providers/user_amount_provider.dart';
import 'package:myecl/tombola/providers/prize_list_provider.dart';
import 'package:myecl/tombola/providers/raffle_provider.dart';
import 'package:myecl/tombola/providers/pack_ticket_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/pages/tombola_page/buy_pack_ticket_card.dart';
import 'package:myecl/tombola/ui/creation_button_anim.dart';
import 'package:myecl/tombola/ui/pages/tombola_page/prize_card.dart';
import 'package:myecl/tombola/ui/tombola.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:myecl/user/providers/user_provider.dart';

class TombolaInfoPage extends HookConsumerWidget {
  const TombolaInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    final userId = ref.watch(idProvider);
    final raffle = ref.watch(raffleProvider);
    final solde = ref.watch(userAmountProvider);
    final soldeNotifier = ref.read(userAmountProvider.notifier);
    final packTicketList = ref.watch(packTicketListProvider);
    final packTicketListNotifier = ref.read(packTicketListProvider.notifier);
    final prizesList = ref.watch(prizeListProvider);
    final prizesListNotifier = ref.read(prizeListProvider.notifier);
    final raffleListNotifier = ref.watch(raffleListProvider.notifier);

    return TombolaTemplate(
      child: Refresher(
        onRefresh: () async {
          userId.whenData(
              (value) async => await soldeNotifier.loadCashByUser(value));
          await typeTicketListNotifier.loadTypeTicketSimpleList();
          await lotsListNotifier.loadLotList();
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                return SizedBox(
                    height: 190,
                    child: typeTickets.isEmpty
                        ? Container(
                            height: 190,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child:
                                const Text(TombolaTextConstants.noTicketBuyable),
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
          lotsList.when(
              data: (lots) {
                lots = lots
                    .where((element) => element.raffleId == raffle.id)
                    .toList();
                return lots.isEmpty
                    ? Container(
                        height: 120,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(TombolaTextConstants.actualPrize,
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: TombolaColorConstants.gradient2,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(TombolaTextConstants.noPrize),
                            ]))
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
              loading: () => Container(
                  height: 120,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(TombolaTextConstants.actualPrize,
                            style: TextStyle(
                                fontSize: 25,
                                color: TombolaColorConstants.gradient2,
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
                        const Text(TombolaTextConstants.actualPrize,
                            style: TextStyle(
                                fontSize: 25,
                                color: TombolaColorConstants.gradient2,
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
                      color: TombolaColorConstants.gradient2)),
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
