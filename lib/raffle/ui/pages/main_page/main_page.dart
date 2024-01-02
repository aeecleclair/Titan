import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/raffle/providers/is_raffle_admin.dart';
import 'package:myecl/raffle/providers/raffle_list_provider.dart';
import 'package:myecl/raffle/providers/user_tickets_provider.dart';
import 'package:myecl/raffle/router.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/raffle/ui/components/section_title.dart';
import 'package:myecl/raffle/ui/pages/main_page/raffle_card.dart';
import 'package:myecl/raffle/ui/pages/main_page/ticket_card.dart';
import 'package:myecl/raffle/ui/raffle.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/user/providers/user_provider.dart';
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
    final user = ref.watch(userProvider);

    final rafflesStatus = {};
    raffleList.whenData(
      (raffles) {
        for (var raffle in raffles) {
          rafflesStatus[raffle.id] = raffle.status;
        }
      },
    );

    return RaffleTemplate(
      child: Refresher(
        onRefresh: () async {
          await userTicketListNotifier.loadTicketList(user.id);
          await raffleListNotifier.loadRaffleList();
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
                      .where((t) =>
                          t.prize != null ||
                          (rafflesStatus.containsKey(t.packTicket.raffleId) &&
                              rafflesStatus[t.packTicket.raffleId] !=
                                  RaffleStatusType.lock))
                      .toList();
                  final ticketSum = <String, List<TicketComplete>>{};
                  final ticketPrice = <String, double>{};
                  for (final ticket in tickets) {
                    if (ticket.prize == null) {
                      final id = ticket.packTicket.raffleId;
                      if (ticketSum.containsKey(id)) {
                        ticketSum[id]!.add(ticket);
                        ticketPrice[id] = ticketPrice[id]! +
                            ticket.packTicket.price /
                                ticket.packTicket.packSize;
                      } else {
                        ticketSum[id] = [ticket];
                        ticketPrice[id] = ticket.packTicket.price /
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
                                  horizontal: 10, vertical: 10),
                              child: TicketWidget(
                                ticket: ticketSum[key]!,
                                price: ticketPrice[key]!,
                              )));
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: AsyncChild(
                    value: raffleList,
                    builder: (context, raffles) {
                      final incomingRaffles = <RaffleComplete>[];
                      final pastRaffles = <RaffleComplete>[];
                      final onGoingRaffles = <RaffleComplete>[];
                      for (final raffle in raffles) {
                        switch (raffle.status) {
                          case RaffleStatusType.creation:
                            incomingRaffles.add(raffle);
                            break;
                          case RaffleStatusType.open:
                            onGoingRaffles.add(raffle);
                            break;
                          case RaffleStatusType.lock:
                            pastRaffles.add(raffle);
                            break;
                          case null:
                            break;
                          case RaffleStatusType.swaggerGeneratedUnknown:
                            break;
                        }
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (onGoingRaffles.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(
                                  bottom: 10, top: 20, left: 5),
                              child: const SectionTitle(
                                  text: RaffleTextConstants.actualRaffles),
                            ),
                          ...onGoingRaffles.map((e) => RaffleWidget(raffle: e)),
                          if (incomingRaffles.isNotEmpty)
                            Container(
                                margin: const EdgeInsets.only(
                                    bottom: 10, top: 20, left: 5),
                                child: const SectionTitle(
                                    text: RaffleTextConstants.nextRaffles)),
                          ...incomingRaffles
                              .map((e) => RaffleWidget(raffle: e)),
                          if (pastRaffles.isNotEmpty)
                            Container(
                                margin: const EdgeInsets.only(
                                    bottom: 10, top: 20, left: 5),
                                child: const SectionTitle(
                                    text: RaffleTextConstants.pastRaffles)),
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
                            )
                        ],
                      );
                    },
                    orElseBuilder: (context, child) => SizedBox(
                          height: 120,
                          child: child,
                        ))),
          ],
        ),
      ),
    );
  }
}
