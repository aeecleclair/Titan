import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/providers/sorted_event_list_provider.dart';
import 'package:myecl/home/tools/constants.dart';
import 'package:myecl/home/ui/day_card.dart';
import 'package:myecl/home/ui/days_event.dart';
import 'package:myecl/home/ui/month_bar.dart';
import 'package:myecl/home/ui/refresh_indicator.dart';
import 'package:myecl/home/ui/top_bar.dart';

class HomePage extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const HomePage({Key? key, required this.controllerNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNotifier = ref.watch(eventListProvider.notifier);
    final sortedEventList = ref.watch(sortedEventListProvider);
    final now = DateTime.now();
    final selectedDay = useState(0);
    const offset = 1;
    final position = useState(0.0);
    final needReload = useState(false);
    final days = List<DateTime>.generate(
        15, (index) => now.add(Duration(days: index - offset)));
    final ScrollController scrollController = useScrollController();

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
                      itemCount: days.length + 2,
                      itemBuilder: (BuildContext context, int i) {
                        if (i == 0 || i == days.length + 1) {
                          return const SizedBox(
                            width: 15,
                          );
                        }
                        return DayCard(
                          isToday: offset == i - 1,
                          isSelected: selectedDay.value == i - 1 - offset,
                          day: days[i - 1],
                          numberOfEvent: Random().nextInt(10),
                          index: i - 1,
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
                      child: sortedEventList.keys.isNotEmpty
                          ? Column(
                              children: sortedEventList
                                  .map((key, value) => MapEntry(
                                      key,
                                      DaysEvent(
                                        day: key,
                                        now: now,
                                        events: value,
                                      )))
                                  .values
                                  .toList())
                          : const Center(
                              child: Text("No events found"),
                            ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
