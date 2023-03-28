import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/class/raffle_status_type.dart';
import 'package:myecl/tombola/providers/is_tombola_admin.dart';
import 'package:myecl/tombola/providers/raffle_list_provider.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/providers/user_tickets_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/pages/main_page/card_tombolas.dart';
import 'package:myecl/tombola/ui/pages/main_page/carte_ticket.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    final raffleList = ref.watch(raffleListProvider);
    final userTicketList = ref.watch(userTicketListProvider);
    final isAdmin = ref.watch(isTombolaAdmin);
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(TombolaTextConstants.tickets,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))),
                if (isAdmin)
                  GestureDetector(
                    onTap: () {
                      pageNotifier.setTombolaPage(TombolaPage.admin);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5))
                          ]),
                      child: Row(
                        children: const [
                          HeroIcon(HeroIcons.userGroup,
                              color: Colors.white, size: 20),
                          SizedBox(width: 10),
                          Text("Admin",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
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
                              return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TicketWidget(
                                    ticket: tickets[index - 1],
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
                    switch (tombola.raffleStatusType) {
                      case RaffleStatusType.creation:
                        incommingRaffles.add(tombola);
                        break;
                      case RaffleStatusType.open:
                        onGoingRaffles.add(tombola);
                        break;
                      case RaffleStatusType.locked:
                        pastRaffles.add(tombola);
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
                            child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(TombolaTextConstants.actualTombolas,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)))),
                      ...onGoingRaffles
                          .map((e) => TombolaWidget(raffle: e))
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
                          .map((e) => TombolaWidget(raffle: e))
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
                          .map((e) => TombolaWidget(raffle: e))
                          .toList(),
                      if (onGoingRaffles.isEmpty &&
                          incommingRaffles.isEmpty &&
                          pastRaffles.isEmpty)
                        const SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                              TombolaTextConstants.noCurrentTombola,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                    ],
                  );
                },
                error: (Object error, StackTrace stackTrace) =>
                    Center(child: Text("Error $error")),
                loading: () => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
