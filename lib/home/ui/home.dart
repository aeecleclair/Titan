import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/home/tools/constants.dart';
import 'package:myecl/home/ui/day_card.dart';
import 'package:myecl/home/ui/last_info.dart';
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
    return Scaffold(
      body: WillPopScope(
          onWillPop: () async {
            controllerNotifier.toggle();
            return false;
          },
          child: HomeRefresher(
            onRefresh: () async {
              await eventNotifier.loadEventList();
            },
            child: SafeArea(
              child: Column(
                children: [
                  TopBar(controllerNotifier: controllerNotifier),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('MyECL',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          DayCard(),
                          DayCard(
                            isSelected: true,
                          ),
                          DayCard(),
                          DayCard(),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
