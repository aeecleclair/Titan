import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/event/providers/event_provider.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/tools/functions.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(eventProvider);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            capitalize(event.name),
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            formatDates(event.start, event.end, event.allDay),
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            capitalize(event.location),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            event.organizer,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            event.description,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ]));
  }
}
