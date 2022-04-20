import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/home/providers/scrollcontroller_provider.dart';
import 'package:myecl/home/providers/today_provider.dart';
import 'package:myecl/home/tools/functions.dart';
import 'package:myecl/home/ui/current_time.dart';
import 'package:myecl/home/ui/hour_bar.dart';
import 'package:myecl/home/ui/hour_bar_item.dart';

class TodaysEvents extends ConsumerWidget {
  const TodaysEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = ref.watch(nowProvider);
    print(today);
    final _scrollController = ref.watch(scrollControllerProvider);
    Timer.periodic(const Duration(milliseconds: 1), (t) {
      if (_scrollController.positions.isNotEmpty) {
        _scrollController.jumpTo(
          (today.hour + today.minute / 60 + today.second / 3600) * 90.0 - 150,
        );
        t.cancel();
      }
    });
    return SizedBox(
      height: MediaQuery.of(context).size.height * .65,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.centerLeft,
              child: Text("Évènements du ${today.day} ${getMonth(today.month)}",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 80,
                      height: 24 * 90.0 + 3,
                      child: HourBar(),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 24 * 90.0 + 3,
                        child: Stack(
                          children: const [HourBarItems(), CurrentTime()],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
