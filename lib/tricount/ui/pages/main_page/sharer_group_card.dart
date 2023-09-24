import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tricount/class/sharer_group.dart';
import 'package:myecl/tricount/ui/pages/main_page/overlapping_avatar.dart';

class SharerGroupCard extends HookConsumerWidget {
  final SharerGroup sharerGroup;
  final int depth;
  final double offset;
  const SharerGroupCard({
    super.key,
    required this.sharerGroup,
    required this.depth,
    required this.offset,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = 4.47 * MediaQuery.of(context).size.width / 10;
    final x = depth - offset;
    final angle = (22.5 * x * x + 22.5 * x) * 3.14 / 180;
    final translation = ((40 - width) * x * x + (width + 40) * x);
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(angle)
        ..scale(1 - 0.15 * x.abs())
        ..translate(translation, 0, 0),
      child: CardLayout(
          color: Colors.white,
          child: Column(children: [
            Text(sharerGroup.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Expanded(
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff1C4668), width: 15),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Text(
                        "${sharerGroup.totalAmount.toStringAsFixed(2)}€",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        for (var i = 0;
                            i < min(sharerGroup.transactions.length, 3);
                            i++)
                          if (i < 3)
                            SizedBox(
                                height: 40,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(sharerGroup.transactions[i]
                                                    .payer.nickname !=
                                                null
                                            ? sharerGroup
                                                .transactions[i].payer.nickname!
                                            : sharerGroup
                                                .transactions[i].payer.name)),
                                    Text(
                                        "${sharerGroup.transactions[i].amount.toStringAsFixed(2)}€")
                                  ],
                                )),
                        const Spacer(),
                        SizedBox(
                            height: 40,
                            child:
                                OverlappingAvatar(users: sharerGroup.sharers)),
                      ],
                    ),
                  )
                ],
              ),
            )
          ])),
    );
  }
}
