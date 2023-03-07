import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/class/type_ticket.dart';
import 'package:myecl/tombola/providers/raffle_list_provider.dart';
import 'package:myecl/tombola/providers/type_ticket_provider.dart';
import 'package:myecl/tombola/providers/user_tickets_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/pages/main_page/card_tombolas.dart';
import 'package:myecl/tombola/ui/pages/main_page/carte_ticket.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffleList = ref.watch(raffleListProvider);
    final userTicketList = ref.watch(userTicketListProvider);
    final typeTicketsList = ref.watch(typeTicketsListProvider);
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(TombolaTextConstants.tickets,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)))),
          const SizedBox(
            height: 10,
          ),
          userTicketList.when(
              data: (tickets) {
                return tickets.isEmpty
                    ? const Center(
                        child: Text(TombolaTextConstants.noTicket),
                      )
                    : SizedBox(
                        height: 210,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: tickets.length + 2,
                            itemBuilder: (context, index) {
                              if (index == 0 || index == tickets.length + 1) {
                                return const SizedBox(
                                  width: 15,
                                );
                              }
                              final raffle = raffleList.when(
                                  data: (raffles) => raffles.firstWhere(
                                      (element) =>
                                          element.id ==
                                          tickets[index - 1].raffleId,
                                      orElse: () => Raffle.empty()),
                                  error: (e, s) => Raffle.empty(),
                                  loading: () => Raffle.empty());
                              return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TicketWidget(
                                    ticket: tickets[index - 1],
                                    raffle: raffle,
                                  ));
                            }));
              },
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
              error: (error, stack) => const Center(
                    child: Text('Error'),
                  )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: raffleList.when(
                data: (tombolas) {
                  final incommingRaffles = <Raffle>[];
                  final pastRaffles = <Raffle>[];
                  final onGoingRaffles = <Raffle>[];
                  for (final tombola in tombolas) {
                    if (tombola.startDate.isAfter(DateTime.now())) {
                      incommingRaffles.add(tombola);
                    } else if (tombola.endDate.isBefore(DateTime.now())) {
                      pastRaffles.add(tombola);
                    } else {
                      onGoingRaffles.add(tombola);
                    }
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (onGoingRaffles.isNotEmpty)
                        Container(
                            margin: const EdgeInsets.only(
                                bottom: 10, top: 20, left: 5),
                            child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(TombolaTextConstants.actualTombolas,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)))),
                      ...onGoingRaffles
                          .map((e) => TombolaWidget(name: e.name))
                          .toList(),
                      if (incommingRaffles.isNotEmpty)
                        Container(
                            margin: const EdgeInsets.only(
                                bottom: 10, top: 20, left: 5),
                            child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(TombolaTextConstants.nextTombolas,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)))),
                      ...incommingRaffles
                          .map((e) => TombolaWidget(name: e.name))
                          .toList(),
                      if (pastRaffles.isNotEmpty)
                        Container(
                            margin: const EdgeInsets.only(
                                bottom: 10, top: 20, left: 5),
                            child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(TombolaTextConstants.pastTombolas,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)))),
                      ...pastRaffles
                          .map((e) => TombolaWidget(name: e.name))
                          .toList(),
                    ],
                  );
                },
                error: (Object error, StackTrace stackTrace) =>
                    Text("Error $error"),
                loading: () => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
