import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SessionCard extends HookConsumerWidget {
  final VoidCallback onTap;
  final String sessionName;

  const SessionCard({
    super.key,
    required this.onTap,
    required this.sessionName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const BorderRadius radius = BorderRadius.all(Radius.circular(20));

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: radius,
            boxShadow: const [
              BoxShadow(
                blurRadius: 24,
                offset: Offset(0, 12),
                spreadRadius: -6,
                color: Color(0x1F1E2A78),
              ),
              BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 1),
                color: Color(0x0F000000),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: radius,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
                child: Row(
                  children: [
                    // Leading icon
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.event_note_rounded,
                        size: 22,
                        color: Colors.indigo.shade600,
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Title
                    Expanded(
                      child: Text(
                        sessionName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                          color: Color(0xFF1A1C2E),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Trailing chevron
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 24,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
