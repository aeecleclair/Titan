import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/event/providers/confirmed_event_list_provider.dart';
import 'package:myecl/event/providers/sorted_event_list_provider.dart';
import 'package:myecl/home/tools/constants.dart';
import 'package:myecl/home/ui/day_list.dart';
import 'package:myecl/home/ui/days_event.dart';
import 'package:myecl/home/ui/month_bar.dart';
import 'package:myecl/home/ui/top_bar.dart';
import 'package:myecl/tools/ui/refresher.dart';

class HomePage extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  final AnimationController controller;
  const HomePage(
      {Key? key, required this.controllerNotifier, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final confimedEventListNotifier =
        ref.watch(confirmedEventListProvider.notifier);
    final sortedEventList = ref.watch(sortedEventListProvider);
    DateTime now = DateTime.now();
    final ScrollController scrollController = useScrollController();
    final daysEventScrollController = useScrollController();

    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        if (!controller.isCompleted) {
          controllerNotifier.toggle();
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
          child: IgnorePointer(
        ignoring: controller.isCompleted,
        child: Refresher(
            onRefresh: () async {
              await confimedEventListNotifier.loadConfirmedEvent();
              now = DateTime.now();
            },
            child: Column(children: [
              TopBar(controllerNotifier: controllerNotifier),
              MonthBar(
                  scrollController: scrollController,
                  width: MediaQuery.of(context).size.width),
              const SizedBox(
                height: 10,
              ),
              DayList(scrollController, daysEventScrollController),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(HomeTextConstants.incomingEvents,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height - 345,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: daysEventScrollController,
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
                            child: Text(
                              HomeTextConstants.noEvents,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 149, 149, 149)),
                            ),
                          ),
                  ))
            ])),
      )),
    ));
  }
}
