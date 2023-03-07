import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tombola/providers/raffle_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/pages/tombola_page/prize_card.dart';

class TombolaInfoPage extends HookConsumerWidget {
  const TombolaInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffle = ref.watch(raffleProvider);
    return Container(
        margin: const EdgeInsets.only(top: 15),
        child: ListView(children: [
          Center(
              child: Text(raffle.name, style: const TextStyle(fontSize: 30))),
          const Center(
              child: Text(TombolaTextConstants.majorPrize,
                  style: TextStyle(fontSize: 20))),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                PrizeCard(color: Colors.red),
                PrizeCard(color: Colors.blue),
                PrizeCard(color: Colors.yellowAccent),
              ]),
          const Text("Description", style: TextStyle(fontSize: 30)),
          const SizedBox(
            height: 100,
          ),
        ]));
    //   const Positioned(
    //     bottom: 10,
    //     right: 10,
    //     child: PersoButton(text: "Modifiez votre tombola [SI CREATEUR]"),
    //   ),const Positioned(
    //     bottom: 60,
    //     right: 10,
    //     child: PersoButton(text: TombolaTextConstants.takeTickets),
    //   ),
    // ]);
  }
}
