import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/home/tools/constants.dart';
import 'package:myecl/home/tools/functions.dart';
import 'package:myecl/home/ui/day_card.dart';
import 'package:myecl/home/ui/month_bar.dart';
import 'package:myecl/home/ui/refresh_indicator.dart';
import 'package:myecl/home/ui/todays_events.dart';
import 'package:myecl/home/ui/top_bar.dart';

class HomePage extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const HomePage({Key? key, required this.controllerNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNotifier = ref.watch(eventListProvider.notifier);
    final now = DateTime.now();
    final selectedDay = useState(0);
    const offset = 1;
    final position = useState(0.0);
    final needReload = useState(false);
    final days = List<DateTime>.generate(
        10, (index) => now.add(Duration(days: index - offset)));
    final ScrollController scrollController = useScrollController();

    // Future.delayed(Duration(microseconds: 1)).then(((value) {
      // scrollController.jumpTo(position.value);
    // }));
    // if (needReload.value) {
    //   print('in');
    //   print(position.value);
    //   scrollController.jumpTo(position.value);
    //   if (scrollController.position.pixels == position.value) {
    //     needReload.value = false;
    //   }
    //   print(scrollController.position.pixels);
    // }

    return Scaffold(
      body: WillPopScope(
          onWillPop: () async {
            controllerNotifier.toggle();
            return false;
          },
          child: SafeArea(
            child: HomeRefresher(
              onRefresh: () async {
                await eventNotifier.loadEventList();
              },
              child: Column(
                children: [
                  TopBar(controllerNotifier: controllerNotifier),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(HomeTextConstants.calendar,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MonthBar(
                      scrollController: scrollController,
                      days: days,
                      offset: offset),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 125,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      controller: scrollController,
                      itemCount: days.length,
                      itemBuilder: (BuildContext context, int i) {
                        return DayCard(
                          isToday: offset == i,
                          isSelected: selectedDay.value == i - offset,
                          day: days[i],
                          numberOfEvent: Random().nextInt(10),
                          index: i,
                          offset: offset,
                          notifier: selectedDay,
                          onTap: () {
                            position.value = scrollController.position.pixels;
                            needReload.value = true;
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(HomeTextConstants.incomingEvents,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height - 370,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(children: []),
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
