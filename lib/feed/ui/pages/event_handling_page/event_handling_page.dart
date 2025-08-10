import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/ui/feed.dart';

class EventHandlingPage extends HookConsumerWidget {
  const EventHandlingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FeedTemplate(child: Container());
  }
}
