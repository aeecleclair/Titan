import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class PermissionRow extends StatelessWidget {
  final String label;
  final bool isAuthorized;
  final VoidCallback onAuthorize;
  final VoidCallback onUnauthorize;

  const PermissionRow({
    super.key,
    required this.label,
    required this.isAuthorized,
    required this.onAuthorize,
    required this.onUnauthorize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          IconButton(
            onPressed: isAuthorized ? onUnauthorize : onAuthorize,
            splashRadius: 22,
            icon: HeroIcon(
              isAuthorized ? HeroIcons.check : HeroIcons.xMark,
              size: 34,
              color: isAuthorized ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
