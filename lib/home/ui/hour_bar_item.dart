import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/home/tools/functions.dart';

class HourBarItems extends ConsumerWidget {
  const HourBarItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final res = ref.watch(eventListProvider);
    List<Widget> hourBar = [];
    int dh = 0;
    double dl = 0;
    res.when(
      data: (data) {
        for (Event r in data) {
          int h = r.start.hour;
          double l = (r.end.hour - r.start.hour) +
              (r.end.minute - r.start.minute) / 60;
          int ph = h - dh;
          hourBar.add(SizedBox(
            height: (ph - dl) * 90.0,
          ));
          hourBar.add(
            Container(
              margin:
                  const EdgeInsets.only(left: 20, right: 15, top: 2, bottom: 2),
              width: 500,
              height: l * 90.0 - 4,
              decoration: BoxDecoration(
                color: uuidToColor(r.id),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Text(r.name,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                      const SizedBox(
                        height: 3,
                      ),
                      l > 0.5
                          ? Text(doubleToTime(l),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.5)))
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          );
          dh = h;
          dl = l;
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
