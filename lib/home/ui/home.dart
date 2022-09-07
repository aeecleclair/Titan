import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/home/tools/constants.dart';
import 'package:myecl/home/ui/last_info.dart';
import 'package:myecl/home/ui/todays_events.dart';
import 'package:myecl/home/ui/top_bar.dart';

class HomePage extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const HomePage({Key? key, required this.controllerNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
                  HomeColorConstants.darkBlue,
                  HomeColorConstants.lightBlue,
                ],
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  TopBar(controllerNotifier: controllerNotifier),
                  const TodaysEvents(),
                  const LastInfos(),
                ],
              ),
            )));
  }
}
