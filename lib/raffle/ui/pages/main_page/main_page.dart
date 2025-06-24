import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/raffle/class/raffle.dart';
import 'package:titan/raffle/class/raffle_status_type.dart';
import 'package:titan/raffle/class/tickets.dart';
import 'package:titan/raffle/providers/is_raffle_admin.dart';
import 'package:titan/raffle/providers/raffle_list_provider.dart';
import 'package:titan/raffle/providers/tombola_logos_provider.dart';
import 'package:titan/raffle/providers/user_tickets_provider.dart';
import 'package:titan/raffle/router.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/raffle/ui/components/section_title.dart';
import 'package:titan/raffle/ui/pages/main_page/raffle_card.dart';
import 'package:titan/raffle/ui/pages/main_page/ticket_card.dart';
import 'package:titan/raffle/ui/raffle.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/widgets/admin_button.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RaffleMainPage extends HookConsumerWidget {
  const RaffleMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffleList = ref.watch(raffleListProvider);
    final raffleListNotifier = ref.watch(raffleListProvider.notifier);
    final userTicketList = ref.watch(userTicketListProvider);
    final userTicketListNotifier = ref.watch(userTicketListProvider.notifier);
    final isAdmin = ref.watch(isRaffleAdminProvider);
    final tombolaLogosNotifier = ref.watch(tombolaLogosProvider.notifier);

    final rafflesStatus = {};
    raffleList.whenData((raffles) {
      for (var raffle in raffles) {
        rafflesStatus[raffle.id] = raffle.raffleStatusType;
      }
    });

    return RaffleTemplate(
      child: Refresher(
        onRefresh: () async {
          await userTicketListNotifier.loadTicketList();
          await raffleListNotifier.loadRaffleList();
          tombolaLogosNotifier.resetTData();
        },
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SectionTitle(text: RaffleTextConstants.tickets),
                  if (isAdmin)
                    AdminButton(
                      onTap: () {
                        QR.to(RaffleRouter.root + RaffleRouter.admin);
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 210,
              child: AsyncChild(
                value: userTicketList,
                builder: (context, tickets) {
                  tickets = tickets
                      .where(
                        (t) =>
                            t.prize != null ||
                            (rafflesStatus.containsKey(t.packTicket.raffleId) &&
                                rafflesStatus[t.packTicket.raffleId] !=
                                    RaffleStatusType.lock),
                      )
                      .toList();
                  final ticketSum = <String, List<Ticket>>{};
                  final ticketPrice = <String, double>{};
                  for (final ticket in tickets) {
                    if (ticket.prize == null) {
                      final id = ticket.packTicket.raffleId;
                      if (ticketSum.containsKey(id)) {
                        ticketSum[id]!.add(ticket);
                        ticketPrice[id] =
                            ticketPrice[id]! +
                            ticket.packTicket.price /
                                ticket.packTicket.packSize;
                      } else {
                        ticketSum[id] = [ticket];
                        ticketPrice[id] =
                            ticket.packTicket.price /
                            ticket.packTicket.packSize;
                      }
                    } else {
                      final id = ticketSum.length.toString();
                      ticketSum[id] = [ticket];
                      ticketPrice[id] =
                          ticket.packTicket.price / ticket.packTicket.packSize;
                    }
                  }
                  return ticketSum.isEmpty
                      ? const Center(child: Text(RaffleTextConstants.noTicket))
                      : HorizontalListView.builder(
                          height: 135,
                          items: ticketSum.keys.toList(),
                          itemBuilder: (context, key, index) => Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: TicketWidget(
                              ticket: ticketSum[key]!,
                              price: ticketPrice[key]!,
                            ),
                          ),
                        );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: AsyncChild(
                value: raffleList,
                builder: (context, raffles) {
                  final incomingRaffles = <Raffle>[];
                  final pastRaffles = <Raffle>[];
                  final onGoingRaffles = <Raffle>[];
                  for (final raffle in raffles) {
                    switch (raffle.raffleStatusType) {
                      case RaffleStatusType.creation:
                        incomingRaffles.add(raffle);
                        break;
                      case RaffleStatusType.open:
                        onGoingRaffles.add(raffle);
                        break;
                      case RaffleStatusType.lock:
                        pastRaffles.add(raffle);
                        break;
                    }
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (onGoingRaffles.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 10,
                            top: 20,
                            left: 5,
                          ),
                          child: const SectionTitle(
                            text: RaffleTextConstants.actualRaffles,
                          ),
                        ),
                      ...onGoingRaffles.map((e) => RaffleWidget(raffle: e)),
                      if (incomingRaffles.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 10,
                            top: 20,
                            left: 5,
                          ),
                          child: const SectionTitle(
                            text: RaffleTextConstants.nextRaffles,
                          ),
                        ),
                      ...incomingRaffles.map((e) => RaffleWidget(raffle: e)),
                      if (pastRaffles.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 10,
                            top: 20,
                            left: 5,
                          ),
                          child: const SectionTitle(
                            text: RaffleTextConstants.pastRaffles,
                          ),
                        ),
                      ...pastRaffles.map((e) => RaffleWidget(raffle: e)),
                      if (onGoingRaffles.isEmpty &&
                          incomingRaffles.isEmpty &&
                          pastRaffles.isEmpty)
                        const SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                              RaffleTextConstants.noCurrentRaffle,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                    ],
                  );
                },
                orElseBuilder: (context, child) =>
                    SizedBox(height: 120, child: child),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
