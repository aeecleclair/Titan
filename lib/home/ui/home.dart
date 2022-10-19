import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/home/tools/constants.dart';
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
        child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HomeColorConstants.darkBlue,
                  HomeColorConstants.lightBlue,
                ],
              ),
            ),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: SafeArea(
                child: Column(
                  children: [
                    TopBar(controllerNotifier: controllerNotifier),
                    const TodaysEvents(),
                    const LastInfos(),
                  ],
                ),
              ),
            )),
      ),
    ));
  }
}
