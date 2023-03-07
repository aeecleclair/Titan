import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/providers/raffle_list_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/card_tombolas.dart';
import 'package:myecl/tombola/ui/pages/main_page/carte_ticket.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    // final eventListNotifier = ref.watch(raffleListProvider.notifier);
    final tombolas = ref.watch(raffleListProvider);
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
          Column(
              children: tombolas.when(data: (tombolas) {
            return tombolas
                .map((e) => Text("tombola :  ${e.toJson()['name']}"))
                .toList();
          }, loading: () {
            return [
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            ];
          }, error: (error, stack) {
            return [
              Center(
                child: Text("Error $error"),
              )
            ];
          })),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 20, left: 5),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(TombolaTextConstants.actualTombolas,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)))),
              const TombolaWidget(name: "Tombola Soli Sida"),
              const TombolaWidget(name: "Tombola 2"),
              Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 30, left: 5),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(TombolaTextConstants.pastTombolas,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)))),
              const TombolaWidget(name: "Tombola 3"),
              const TombolaWidget(name: "Tombola 4"),
            ]),
          ),
        ],
      ),
    );
  }
}
