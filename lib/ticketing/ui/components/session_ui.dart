import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/cinema/class/session.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';

class SessionUi extends HookConsumerWidget {
  final Session session;

  const SessionUi({super.key, required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CardLayout(
      width: double.infinity,
      height: 100,
      child: Center(child: Text('Session: ${session.name}')),
    );
  }
}
