import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/providers/raffle_list_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import '../../../class/raffle.dart';
import '../../../providers/tombola_page_provider.dart';

import 'carte_ticket.dart';
import '../../card_tombolas.dart';
import '../../button_perso.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    final eventListNotifier = ref.watch(raffleListProvider.notifier);
    final tombolas = ref.watch(raffleListProvider);
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                  width: 100,
                  child: Center(
                      child: Text(TombolaTextConstants.tickets,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20)))),
              GestureDetector(
                  onTap: () {
                    pageNotifier.setTombolaPage(TombolaPage.create);
                  },
                  child: const SizedBox(
                      width: 200,
                      child:
                          PersoButton(text: TombolaTextConstants.createMenu))),
            ],
          )),
          Center(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 5),
                      padding: const EdgeInsets.only(bottom: 10, top: 5),
                      child: Row(
                        children: [
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
                      )))),
          
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 20,left:5),
              child: const Text(
                TombolaTextConstants.actualTombolas,
                style: TextStyle(fontSize: 30),
              ),
            ),
            
            const TombolaWidget(name: "Tombola Soli Sida"),
            const TombolaWidget(
                name: "Tombola 2"),
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 30,left:5),
              child: const Text(
                TombolaTextConstants.pastTombolas,
                style: TextStyle(fontSize: 30),
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: tombolas.when(data: (tombolas) {
                return tombolas.map((e) =>  TombolaWidget(name:"tombola :  ${e.toJson()['name']}")).toList();
              }, loading: () {
                 return [const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 114, 21, 4),
                  ),
                )];
              }, error: (error, stack) {
                 return [Center(
                  child: Text("Error $error"),
                )];
              })
            
          ),
          ]),
          
        ],
      ),
    );
  }
}
