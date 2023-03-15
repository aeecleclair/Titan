import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/tools/constants.dart';

import 'price_ticket_card.dart';
import 'prize_card_edit.dart';

class CreateAddEditPage extends HookConsumerWidget {
  const CreateAddEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    //final isAdmin = ref.watch(isTombolaAdmin);
    return Container(
        margin: const EdgeInsets.only(top: 15),
        child: ListView(physics: const BouncingScrollPhysics(), children: [
          const Center(
              child: Text("Tombola.nom [à faire]",
                  style: TextStyle(fontSize: 30))),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  TombolaTextConstants.prize,
                  style: TextStyle(fontSize: 40),
                ),
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
            PrizeCardEdit(color: Colors.red),
            PrizeCardEdit(color: Colors.yellowAccent),
          ]),
          const SizedBox(height: 50),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  TombolaTextConstants.possiblePrice,
                  style: TextStyle(fontSize: 40),
                ),
              ],
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
            PriceCard(),
          ]),
          const SizedBox(
            height: 50,
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: const [
                Text(
                  TombolaTextConstants.information,
                  style: TextStyle(fontSize: 40),
                ),
                Text(
                  "Ici on mets toute les infos qu'ils voulaient avoir : plus grand donateurs, argent récoltés, ... reste à voir comment on gère les infos public",
                )
              ]))
        ]));
  }
}
