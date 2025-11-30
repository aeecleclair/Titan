import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/cinema/class/session.dart';

class ListSessionUi extends HookConsumerWidget {
  final Session session;
  final VoidCallback onTap;
  const ListSessionUi({super.key, required this.session, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        child: Text("Coucou"),
      ),
    );
  }
}
