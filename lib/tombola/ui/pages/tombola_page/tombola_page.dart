import 'package:auto_size_text/auto_size_text.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/raffle_status_type.dart';
import 'package:myecl/tombola/providers/raffle_list_provider.dart';
import 'package:myecl/tombola/providers/user_amount_provider.dart';
import 'package:myecl/tombola/providers/prize_list_provider.dart';
import 'package:myecl/tombola/providers/raffle_provider.dart';
import 'package:myecl/tombola/providers/pack_ticket_provider.dart';
import 'package:myecl/tombola/providers/winning_ticket_list_provider.dart';
import 'package:myecl/tombola/router.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/pages/creation_edit_page/winning_ticket_handler.dart';
import 'package:myecl/tombola/ui/pages/tombola_page/buy_pack_ticket_card.dart';
import 'package:myecl/tombola/ui/creation_button_anim.dart';
import 'package:myecl/tombola/ui/pages/tombola_page/prize_card.dart';
import 'package:myecl/tombola/ui/tombola.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TombolaInfoPage extends HookConsumerWidget {
  const TombolaInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(idProvider);
    final raffle = ref.watch(raffleProvider);
    final solde = ref.watch(userAmountProvider);
    final soldeNotifier = ref.read(userAmountProvider.notifier);
    final packTicketList = ref.watch(packTicketListProvider);
    final packTicketListNotifier = ref.read(packTicketListProvider.notifier);
    final prizesList = ref.watch(prizeListProvider);
    final prizesListNotifier = ref.read(prizeListProvider.notifier);
    final raffleListNotifier = ref.watch(raffleListProvider.notifier);
    final winningTicketList = ref.watch(winningTicketListProvider);
    final prizeList = ref.watch(prizeListProvider);

    final me = ref.watch(userProvider);
    final isThisTombolaAdmin =
        me.groups.map((e) => e.id).contains(raffle.group.id);

    return TombolaTemplate(
      child: Refresher(
        onRefresh: () async {
          userId.whenData(
              (value) async => await soldeNotifier.loadCashByUser(value));
          await packTicketListNotifier.loadPackTicketList();
          await prizesListNotifier.loadPrizeList();
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.only(left: 30, right: 20, top: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
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
                            child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: AutoSizeText(
                                  raffle.name,
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )))),
                    if (isThisTombolaAdmin &&
                        (raffle.raffleStatusType != RaffleStatusType.lock))
                      GestureDetector(
                          onTap: () {
                            QR.to(RaffleRouter.root +
                                RaffleRouter.detail +
                                RaffleRouter.creation);
                          },
                          child: const CustomButton(text: 'Modifier')),
                    if (isThisTombolaAdmin &&
                        raffle.raffleStatusType == RaffleStatusType.lock)
                      GestureDetector(
                          onTap: () async {
                            await tokenExpireWrapper(ref, () async {
                              final winningTicketNumber =
                                  winningTicketList.when(
                                      data: (winningTicketList) =>
                                          winningTicketList.length,
                                      loading: () => 0,
                                      error: (err, stack) => 0);
                              final prizeNumber = prizeList.when(
                                  data: (prizeList) => prizeList
                                      .where((e) => e.raffleId == raffle.id)
                                      .fold<int>(
                                          0,
                                          (previousValue, element) =>
                                              previousValue + element.quantity),
                                  loading: () => 0,
                                  error: (err, stack) => 0);
                              if (winningTicketNumber < prizeNumber) {
                                displayToast(context, TypeMsg.error,
                                    TombolaTextConstants.notEnoughPrize);
                                return;
                              }
                              await showDialog(
                                  context: context,
                                  builder: (context) => CustomDialogBox(
                                        descriptions:
                                            'Voulez-vous vraiment supprimer cette tombola (${raffle.name}) ? ATTENTION Cette action est irréversible.',
                                        onYes: () {
                                          raffleListNotifier
                                              .deleteRaffle(raffle);
                                        },
                                        title: 'Supprimer la tombola',
                                      ));
                            });
                            QR.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: TombolaColorConstants.redGradient3
                                        .withOpacity(0.3),
                                    blurRadius: 2,
                                    offset: const Offset(2, 3),
                                  ),
                                ],
                                gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      TombolaColorConstants.redGradient1,
                                      TombolaColorConstants.redGradient2
                                    ]),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: const Row(
                              children: [
                                HeroIcon(HeroIcons.xMark,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 10),
                                Text("Supprimer",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                          )),
                  ])),
          Container(
              margin: const EdgeInsets.only(left: 30, top: 20),
              child: Text(
                  solde.when(
                      data: (s) => "Solde : ${s.balance.toStringAsFixed(2)}€",
                      error: (e, s) => "Erreur",
                      loading: () => "Loading"),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: TombolaColorConstants.gradient2))),
          if (isThisTombolaAdmin &&
              raffle.raffleStatusType == RaffleStatusType.lock)
            Container(
                margin: const EdgeInsets.only(top: 25, bottom: 10),
                child: const WinningTicketHandler()),
          packTicketList.when(
              data: (typeTickets) {
                return SizedBox(
                    height: 190,
                    child: typeTickets.isEmpty
                        ? Container(
                            height: 190,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: const Text(
                                TombolaTextConstants.noTicketBuyable),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: typeTickets.length + 2,
                            itemBuilder: (context, index) {
                              if (index == 0 ||
                                  index == typeTickets.length + 1) {
                                return const SizedBox(
                                  width: 15,
                                );
                              }
                              return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: BuyPackTicket(
                                      packTicket: typeTickets[index - 1],
                                      raffle: raffle));
                            }));
              },
              loading: () => Container(
                  height: 190,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  )),
              error: (error, stack) => Container(
                    height: 190,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text('Error $error'),
                  )),
          prizesList.when(
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
              padding: const EdgeInsets.only(
                  top: 20, bottom: 10, left: 30, right: 30),
              child: const Text("Description",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: TombolaColorConstants.gradient2)),
            ),
          Container(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 10, left: 30, right: 30),
              child: Text(raffle.description ?? "",
                  style: const TextStyle(fontSize: 15))),
        ]),
      ),
    );
  }
}
