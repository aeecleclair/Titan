import 'package:flutter/material.dart';
import 'package:myecl/event/class/event.dart';
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
                      fontSize: 18, color: Color.fromARGB(255, 205, 205, 205))),
            ),
            const SizedBox(
              height: 10,
            ),
            for (final event in events)
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: event.end.compareTo(now) < 0
                        ? Colors.black
                        : event.start.compareTo(now) <= 0
                            ? Colors.deepOrange
                            : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name,
                        style: TextStyle(
                            color: isDateBetween(now, event.start, event.end)
                                ? Colors.white
                                : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        event.description,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        event.location,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ));
  }
}
