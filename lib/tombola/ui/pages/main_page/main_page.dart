import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'carte_ticket.dart';
import 'carte_tombolas.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: ListView(
        children: [
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.withOpacity(0.4),
                        Colors.blue,
                      ],
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(40))),
                child: Text(
                  TombolaTextConstants.tickets,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ],
          )),
          Container(
            margin:const EdgeInsets.only(bottom: 10, top: 5),
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
            Container(margin: EdgeInsets.only(bottom:10,top:20),
              child: Text(
                TombolaTextConstants.actualTombolas,
                style: TextStyle(fontSize: 30),
              ),
            ),
            TombolaWidget(name: "Tombola Soli Sida", color: Color(0xffbd7efe)),
            TombolaWidget(name: "Tombola 2", color: Color(0xffed7ede)),
            Container(margin: EdgeInsets.only(bottom:10,top:30),
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
