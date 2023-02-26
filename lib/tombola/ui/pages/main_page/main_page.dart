import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/tools/constants.dart';
import '../../../providers/tombola_page_provider.dart';

import 'carte_ticket.dart';
import 'carte_tombolas.dart';
import 'button_perso.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: ListView(
        children: [
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: 100,
                  child: Center(
                      child: Text(TombolaTextConstants.tickets,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20)))),
              GestureDetector(
                  onTap: () {
                    pageNotifier.setTombolaPage(TombolaPage.admin);
                  },
                  child: SizedBox(
                      width: 200,
                      child: PresButton(text: TombolaTextConstants.askRaffle))),
            ],
          )),
          Container(
              margin: const EdgeInsets.only(bottom: 10, top: 5),
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TicketWidget(
                        color: Color(0xffcdaeee),
                      ),
                      TicketWidget(
                        color: Color(0xffedaede),
                      ),
                      TicketWidget(
                        color: Color(0xffefbeae),
                      ),
                      TicketWidget(
                        color: Color(0xff9dfede),
                      )
                    ],
                  ))),
          Column(children: [
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 20),
              child: Text(
                TombolaTextConstants.actualTombolas,
                style: TextStyle(fontSize: 30),
              ),
            ),
            TombolaWidget(name: "Tombola Soli Sida", color: Color(0xffbd7efe)),
            TombolaWidget(name: "Tombola 2", color: Color(0xffed7ede)),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 30),
              child: Text(
                TombolaTextConstants.pastTombolas,
                style: TextStyle(fontSize: 30),
              ),
            ),
            TombolaWidget(name: "Tombola 3", color: Colors.blue),
            TombolaWidget(name: "Tombola 4", color: Colors.red),
          ]),
        ],
      ),
    );
  }
}
