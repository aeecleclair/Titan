import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/providers/raffle_list_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/card_tombolas.dart';
import 'package:myecl/tombola/ui/pages/main_page/carte_ticket.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffleList = ref.watch(raffleListProvider);
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 10,
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
          SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: const [
                      TicketWidget(
                        color: Color.fromARGB(255, 132, 63, 206),
                      ),
                      TicketWidget(
                        color: Color.fromARGB(255, 212, 100, 186),
                      ),
                      TicketWidget(
                        color: Color.fromARGB(255, 232, 168, 147),
                      ),
                      TicketWidget(
                        color: Color.fromARGB(255, 117, 229, 192),
                      )
                    ],
                  ))),
          const SizedBox(
            height: 20,
          ),
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
                                bottom: 10, top: 30, left: 5),
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
                                bottom: 10, top: 30, left: 5),
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
