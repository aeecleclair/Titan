import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/button_perso.dart';

import 'prize_card.dart';

class TombolaInfoPage extends HookConsumerWidget {
  const TombolaInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    return Stack(children: [
      Container(
          margin: EdgeInsets.only(top: 15),
          child: ListView(children: [
            Center(
                child: Text("[à faire] Tombola.nom",
                    style: TextStyle(fontSize: 30))),
            Center(
                child: const Text(TombolaTextConstants.majorPrize,
                    style: TextStyle(fontSize: 20))),
            Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  PrizeCard(color: Colors.red),
                  PrizeCard(color: Colors.blue),
                  PrizeCard(color: Colors.yellowAccent),
                ])),
                Text(
                "Description",
                style: TextStyle(fontSize: 30)),
                SizedBox(height: 100,),
        
          ])),
      Positioned(
        bottom: 10,
        right: 10,
        child: PersoButton(text: "Modifiez votre tombola [SI CREATEUR]"),
      ),Positioned(
        bottom: 60,
        right: 10,
        child: PersoButton(text: TombolaTextConstants.takeTickets),
      ),
    ]);
  }
}
