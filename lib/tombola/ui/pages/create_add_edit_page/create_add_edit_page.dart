import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/add_button.dart';

import '../../../providers/tombola_page_provider.dart';

class CreateAddEditPage extends HookConsumerWidget {
  const CreateAddEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    //final isAdmin = ref.watch(isTombolaAdmin);
    return Container(
        margin: EdgeInsets.only(top: 15,left:20,right:20),
        child: ListView(physics: const BouncingScrollPhysics(), children: [
          Center(
              child: Text("Tombola.nom [à faire]",
                  style: TextStyle(fontSize: 30))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TombolaTextConstants.prize,
                style: TextStyle(fontSize: 40),
              ),
              GestureDetector(
                    onTap: () {
                      pageNotifier.setTombolaPage(TombolaPage.addEditLots);
                    },
                    child:AddButton(text: "+", size: 50,))
            ],
          ),
          SizedBox(height:100,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TombolaTextConstants.possiblePrice,
                style: TextStyle(fontSize: 40),
              ),
              GestureDetector(
                    onTap: () {
                      pageNotifier.setTombolaPage(TombolaPage.addEditTypeTickets);
                    },
                    child:AddButton(text: "+", size: 50))
            ],
          ),
          SizedBox(height: 100,),
          Text(TombolaTextConstants.information,
                style: TextStyle(fontSize: 40),),
          Text("Ici on mets toute les infos qu'ils voulaient avoir : plus grand donateurs, argent récoltés, ... reste à voir comment on gère les infos public",
                ),
        ]));
  }
}
