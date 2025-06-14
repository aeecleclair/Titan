import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/providers/should_notify_provider.dart';

class NotificationBadge extends HookConsumerWidget {
  final Widget child;

  const NotificationBadge({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shouldNotify = ref.watch(shouldNotifyProvider);
    return badges.Badge(
      showBadge: shouldNotify,
      position: badges.BadgePosition.topStart(top: -5, start: -10),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.circle,
        badgeGradient: badges.BadgeGradient.linear(
          colors: [Colors.red.shade600, Colors.red.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        elevation: 0,
      ),
      child: child,
    );
  }
}
