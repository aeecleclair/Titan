import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ticketing/providers/session_list_provider.dart';
import 'package:titan/ticketing/class/session.dart';

class SessionSection extends HookConsumerWidget {
  final Session session;
  final String name;
  final VoidCallback? onTap;
  const SessionSection({
    super.key,
    required this.name,
    required this.session,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionListProvider);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCCCCCC)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          for (var session in sessions.value ?? [])
            Text('Session Section: $session.name'),
        ],
      ),
    );
  }
}
