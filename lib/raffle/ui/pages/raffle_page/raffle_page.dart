import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/raffle/providers/pack_ticket_list_provider.dart';
import 'package:titan/raffle/providers/user_amount_provider.dart';
import 'package:titan/raffle/providers/prize_list_provider.dart';
import 'package:titan/raffle/providers/raffle_provider.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/raffle/ui/pages/raffle_page/buy_type_ticket_card.dart';
import 'package:titan/raffle/ui/pages/raffle_page/prize_card.dart';
import 'package:titan/raffle/ui/raffle.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/l10n/app_localizations.dart';

class RaffleInfoPage extends HookConsumerWidget {
  const RaffleInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(idProvider);
    final raffle = ref.watch(raffleProvider);
    final balance = ref.watch(userAmountProvider);
    final balanceNotifier = ref.read(userAmountProvider.notifier);
    final packTicketList = ref.watch(packTicketListProvider);
    final packTicketListNotifier = ref.read(packTicketListProvider.notifier);
    final prizeList = ref.watch(prizeListProvider);
    final prizeListNotifier = ref.read(prizeListProvider.notifier);

    return RaffleTemplate(
      child: Refresher(
        controller: ScrollController(),
        onRefresh: () async {
          userId.whenData(
            (value) async => await balanceNotifier.loadCashByUser(value),
          );
          await packTicketListNotifier.loadPackTicketList();
          await prizeListNotifier.loadPrizeList();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30, top: 20),
              child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const RadialGradient(
                  colors: [
                    RaffleColorConstants.gradient1,
                    RaffleColorConstants.gradient2,
                  ],
                  radius: 6.0,
                  tileMode: TileMode.mirror,
                  center: Alignment.topLeft,
                ).createShader(bounds),
                child: Text(
                  raffle.name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, top: 20),
              child: AsyncChild(
                value: balance,
                builder: (context, s) => Text(
                  "${AppLocalizations.of(context)!.raffleAmount} : ${s.balance.toStringAsFixed(2)}€",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: RaffleColorConstants.gradient2,
                  ),
                ),
                loaderColor: RaffleColorConstants.gradient2,
              ),
            ),
            AsyncChild(
              value: packTicketList,
              builder: (context, packTickets) => packTickets.isEmpty
                  ? Container(
                      height: 190,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        AppLocalizations.of(context)!.raffleNoTicketBuyable,
                      ),
                    )
                  : HorizontalListView.builder(
                      height: 160,
                      items: packTickets,
                      itemBuilder: (context, packTicket, index) => Container(
                        margin: const EdgeInsets.all(10),
                        child: BuyPackTicket(
                          packTicket: packTicket,
                          raffle: raffle,
                        ),
                      ),
                    ),
              orElseBuilder: (context, child) => Container(
                height: 190,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: child,
              ),
            ),
            AsyncChild(
              value: prizeList,
              builder: (context, prizes) {
                prizes = prizes
                    .where((element) => element.raffleId == raffle.id)
                    .toList();
                return prizes.isEmpty
                    ? Container(
                        height: 120,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.raffleActualPrize,
                              style: const TextStyle(
                                fontSize: 25,
                                color: RaffleColorConstants.gradient2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(AppLocalizations.of(context)!.raffleNoPrize),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          AlignLeftText(
                            prizes.isEmpty
                                ? AppLocalizations.of(context)!.raffleNoPrize
                                : AppLocalizations.of(
                                    context,
                                  )!.raffleActualPrize,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 30,
                            ),
                            fontSize: 25,
                            color: RaffleColorConstants.gradient2,
                          ),
                          HorizontalListView.builder(
                            height: 120,
                            items: prizes,
                            itemBuilder: (context, item, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 10,
                              ),
                              child: PrizeCard(prize: item),
                            ),
                          ),
                        ],
                      );
              },
              orElseBuilder: (context, child) => Container(
                height: 120,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.raffleActualPrize,
                      style: const TextStyle(
                        fontSize: 25,
                        color: RaffleColorConstants.gradient2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    child,
                  ],
                ),
              ),
            ),
            if (raffle.description != null)
              Container(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                  left: 30,
                  right: 30,
                ),
                child: Text(
                  AppLocalizations.of(context)!.raffleDescription,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: RaffleColorConstants.gradient2,
                  ),
                ),
              ),
            Container(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 10,
                left: 30,
                right: 30,
              ),
              child: Text(
                raffle.description ?? "",
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
