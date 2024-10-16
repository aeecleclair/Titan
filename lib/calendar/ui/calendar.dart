import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/event/providers/confirmed_event_list_provider.dart';
import 'package:myecl/event/providers/sorted_event_list_provider.dart';
import 'package:myecl/calendar/router.dart';
import 'package:myecl/calendar/tools/constants.dart';
import 'package:myecl/calendar/ui/day_list.dart';
import 'package:myecl/calendar/ui/days_event.dart';
import 'package:myecl/calendar/ui/month_bar.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';

class CalendarPage extends HookConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final confirmedEventListNotifier =
        ref.watch(confirmedEventListProvider.notifier);
    final sortedEventList = ref.watch(sortedEventListProvider);
    DateTime now = DateTime.now();
    final ScrollController scrollController = useScrollController();
    final daysEventScrollController = useScrollController();

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Refresher(
          onRefresh: () async {
            await confirmedEventListNotifier.loadConfirmedEvent();
            now = DateTime.now();
          },
          child: Column(
            children: [
              const TopBar(
                title: CalendarTextConstants.calendar,
                root: CalendarRouter.root,
              ),
              const SizedBox(height: 20),
              MonthBar(
                scrollController: scrollController,
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(height: 10),
              DayList(scrollController, daysEventScrollController),
              const SizedBox(height: 15),
              const AlignLeftText(
                CalendarTextConstants.incomingEvents,
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                fontSize: 25,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height - 320,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: daysEventScrollController,
                  child: sortedEventList.keys.isNotEmpty
                      ? Column(
                          children: sortedEventList
                              .map(
                                (key, value) => MapEntry(
                                  key,
                                  DaysEvent(
                                    day: key,
                                    now: now,
                                    events: value,
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                        )
                      : const Center(
                          child: Text(
                            CalendarTextConstants.noEvents,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
