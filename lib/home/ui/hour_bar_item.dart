import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/home/tools/functions.dart';
import 'package:myecl/home/ui/even_ui.dart';
import 'package:myecl/tools/functions.dart';

class HourBarItems extends ConsumerWidget {
  const HourBarItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final res = ref.watch(eventListProvider);
    final now = DateTime.now();
    final strNow = processDateToAPIWitoutHour(now);
    List<Widget> hourBar = [];
    double dh = 0;
    double dl = 0;
    res.when(
      data: (data) {
        for (Event e in data) {
          if (e.allDay && e.recurrenceRule == "") {
            DateTime newStart =
                DateTime.parse(e.start.toString().split(" ")[0] + " 00:00:00");
            DateTime newEnd =
                DateTime.parse(e.end.toString().split(" ")[0] + " 23:59:00");
            data[data.indexOf(e)] = e.copyWith(start: newStart, end: newEnd);
          }
        }
        data.sort((a, b) => a.start.compareTo(b.start));
        final todaysEvent = data
            .where((element) =>
                processDateToAPIWitoutHour(element.start).compareTo(strNow) <=
                    0 &&
                processDateToAPIWitoutHour(element.end).compareTo(strNow) >= 0)
            .toList();
        int i = 1;
        List<Event> toGather = [];
        while (i < todaysEvent.length) {
          Event r = todaysEvent[i - 1];
          DateTime start = correctBeforeDate(r.start);
          DateTime end = correctAfterDate(r.end);
          Event nextR = todaysEvent[i];
          if (isDateBetween(nextR.start, start, end)) {
            if (!toGather.contains(r)) {
              toGather.add(r);
            }
            toGather.add(nextR);
          } else {
            if (toGather.isEmpty) {
              double h = start.hour + start.minute / 60;
              double l =
                  (end.hour - start.hour) + (end.minute - start.minute) / 60;
              double ph = h - dh;
              hourBar.add(SizedBox(
                height: (ph - dl) * 90.0,
              ));
              hourBar.add(Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 15,
                  ),
                  child: EventUI(r: r, l: l)));
              dh = h;
              dl = l;
            } else {
              DateTime start = correctBeforeDate(toGather[0].start);
              double nextH = start.hour + start.minute / 60;
              List<double> maxL = [];
              hourBar.add(Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: toGather.map((e) {
                        DateTime start = correctBeforeDate(e.start);
                        DateTime end = correctAfterDate(e.end);
                        double h = start.hour + start.minute / 60;
                        double l = (end.hour - start.hour) +
                            (end.minute - start.minute) / 60;
                        maxL.add(l);
                        double ph = h - dh;
                        return Container(
                          width: 180 / toGather.length,
                          margin: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: (ph - dl) * 90.0,
                              ),
                              EventUI(r: e, l: l, n: toGather.length),
                            ],
                          ),
                        );
                      }).toList())));
              toGather = [];
              dh = nextH;
              dl = maxL.reduce(max);
            }
          }
          i++;
        }
        if (toGather.isEmpty) {
          if (todaysEvent.isNotEmpty) {
            Event r = todaysEvent.last;
            DateTime start = correctBeforeDate(r.start);
            DateTime end = correctAfterDate(r.end);
            double h = start.hour + start.minute / 60;
            double l =
                (end.hour - start.hour) + (end.minute - start.minute) / 60;
            double ph = h - dh;
            hourBar.add(SizedBox(
              height: (ph - dl) * 90.0,
            ));
            hourBar.add(Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 15,
                ),
                child: EventUI(r: r, l: l)));
          }
        } else {
          DateTime start = correctBeforeDate(toGather[0].start);
          double nextH = start.hour + start.minute / 60;
          List<double> maxL = [];
          hourBar.add(Container(
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: toGather.map((e) {
                    DateTime start = correctBeforeDate(e.start);
                    DateTime end = correctAfterDate(e.end);
                    double h = start.hour + start.minute / 60;
                    double l = (end.hour - start.hour) +
                        (end.minute - start.minute) / 60;
                    maxL.add(l);
                    double ph = h - dh;
                    return Container(
                      width: 180 / toGather.length,
                      margin: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: (ph - dl) * 90.0,
                          ),
                          EventUI(r: e, l: l, n: toGather.length),
                        ],
                      ),
                    );
                  }).toList())));
          toGather = [];
          dh = nextH;
          dl = maxL.reduce(max);
        }
      },
      loading: () =>
          hourBar.add(const Center(child: CircularProgressIndicator())),
      error: (e, s) => hourBar.add(Text(e.toString())),
    );
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: hourBar);
  }
}
