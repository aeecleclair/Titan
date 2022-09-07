import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/booking/ui/page_switcher.dart';
import 'package:myecl/booking/ui/top_bar.dart';

class BookingPage extends ConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const BookingPage({Key? key, required this.controllerNotifier})
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
            BookingColorConstants.darkBlue,
            BookingColorConstants.lightBlue,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TopBar(
            controllerNotifier: controllerNotifier,
          ),
          const PageSwitcher()
        ],
      ),
    ));
  }
}
