import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/home/class/event.dart';
import 'package:myecl/home/providers/res_provider.dart';
import 'package:myecl/home/tools/functions.dart';

class HourBarItems extends ConsumerWidget {
  const HourBarItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final res = ref.watch(resListProvider);
    List<Widget> hourBar = [];
    double dh = 0;
    double dl = 0;
    for (Event r in res) {
      double ph = r.h - dh;
      hourBar.add(SizedBox(
        height: (ph - dl) * 90.0,
      ));
      hourBar.add(
        Container(
          margin: const EdgeInsets.only(left: 20, right: 15, top: 2, bottom: 2),
          width: 500,
          height: r.l * 90.0 - 4,
          decoration: BoxDecoration(
            color: r.color,
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
                  Text(r.title,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  const SizedBox(
                    height: 3,
                  ),
                  r.l > 0.5
                      ? Text(doubleToTime(r.l),
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
      dh = r.h;
      dl = r.l;
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: hourBar);
  }
}
