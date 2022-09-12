import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/event/providers/event_provider.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(eventProvider);
    return Column(
      children: [
        Text(event.name),
        Text(event.description),
      ],
    );
  }
}