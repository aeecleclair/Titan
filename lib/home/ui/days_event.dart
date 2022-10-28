import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/home/tools/constants.dart';
import 'package:myecl/home/tools/functions.dart';

class DaysEvent extends StatelessWidget {
  final DateTime day, now;
  final List<Event> events;
  const DaysEvent(
      {super.key, required this.day, required this.events, required this.now});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(formatDelayToToday(day, now),
                  style: const TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 205, 205, 205),
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 10,
            ),
            ...events.map((event) {
              final textColor =
                  event.start.compareTo(now) <= 0 ? Colors.white : Colors.black;
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                width: double.infinity,
                height: 169,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: event.end.compareTo(now) < 0
                          ? [
                              Colors.grey.shade700,
                              Colors.grey.shade800,
                            ]
                          : event.start.compareTo(now) <= 0
                              ? [
                                  HomeColorConstants.gradient1,
                                  HomeColorConstants.gradient2,
                                ]
                              : [
                                  Colors.white,
                                  Colors.grey.shade100,
                                ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: event.end.compareTo(now) < 0
                            ? Colors.black.withOpacity(0.2)
                            : event.start.compareTo(now) <= 0
                                ? HomeColorConstants.gradient2.withOpacity(0.2)
                                : Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(3, 3),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            event.name,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: HeroIcon(
                              HeroIcons.ellipsisVertical,
                              color: textColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        formatDates(event.start, event.end),
                        style: TextStyle(
                            color: textColor.withOpacity(0.7), fontSize: 13),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            event.location,
                            style: TextStyle(color: textColor, fontSize: 15),
                          ),
                          Text(
                            event.organizer,
                            style: TextStyle(color: textColor, fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        event.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: textColor.withOpacity(0.7), fontSize: 13),
                      ),
                    ],
                  ),
                ),
              );
            })
          ],
        ));
  }
}
