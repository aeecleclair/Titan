import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/add_button.dart';

import '../../../providers/tombola_page_provider.dart';
import '../../button_perso.dart';
import '../tombola_page/prize_card.dart';
import 'price_ticket_card.dart';
import 'prize_card_edit.dart';

class CreateAddEditPage extends HookConsumerWidget {
  const CreateAddEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    //final isAdmin = ref.watch(isTombolaAdmin);
    return Container(
        margin: EdgeInsets.only(top: 15),
        child: ListView(physics: const BouncingScrollPhysics(), children: [
          Center(
              child: Text("Tombola.nom [à faire]",
                  style: TextStyle(fontSize: 30))),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  TombolaTextConstants.prize,
                  style: TextStyle(fontSize: 40),
                ),
                PersoButton(text: "Ajouter")
              ],
            ),
          ),
          Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                PrizeCardEdit(color: Colors.red),
                PrizeCardEdit(color: Colors.yellowAccent),
              ])),
          SizedBox(height: 50),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  TombolaTextConstants.possiblePrice,
                  style: TextStyle(fontSize: 40),
                ),
                PersoButton(text: "Ajouter")
              ],
            ),
          ),
          Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                PriceCard(),
              ])),
          SizedBox(
            height: 50,
          ),
          Container(
            margin:EdgeInsets.symmetric(horizontal: 10),
            child:Column( children:[Text(
              TombolaTextConstants.information,
              style: TextStyle(fontSize: 40),
            ),
          
          Text(
            "Ici on mets toute les infos qu'ils voulaient avoir : plus grand donateurs, argent récoltés, ... reste à voir comment on gère les infos public",
          )]))
        ]));
  }
}
