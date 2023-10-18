import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tricount/class/sharer_group.dart';
import 'package:myecl/tricount/ui/pages/main_page/overlapping_avatar.dart';
import 'package:myecl/tricount/ui/pages/main_page/sharer_card_layout.dart';

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
    return SharerCardLayout(
      depth: depth,
      offset: offset,
      child: Column(children: [
        Text(sharerGroup.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Expanded(
          child: Row(
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xff1C4668), width: 15),
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: Text(
                    "${sharerGroup.totalAmount.toStringAsFixed(2)}€",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    for (var i = 0;
                        i < min(sharerGroup.transactions.length, 3);
                        i++)
                      SizedBox(
                          height: 32,
                          child: Row(
                            children: [
                              Expanded(
                                  child: AutoSizeText(
                                      sharerGroup.transactions[i].payer
                                                  .nickname !=
                                              null
                                          ? sharerGroup
                                              .transactions[i].payer.nickname!
                                          : sharerGroup
                                              .transactions[i].payer.firstname,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis)),
                              const SizedBox(width: 5),
                              SizedBox(
                                width: 60,
                                child: Text(
                                    "${sharerGroup.transactions[i].amount.toStringAsFixed(2)}€"),
                              )
                            ],
                          )),
                    const Spacer(),
                    SizedBox(
                        height: 40,
                        child: OverlappingAvatar(users: sharerGroup.sharers)),
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
