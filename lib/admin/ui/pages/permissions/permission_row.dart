import 'package:flutter/widgets.dart';
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          GestureDetector(
            onTap: isAuthorized ? onUnauthorize : onAuthorize,
            child: HeroIcon(
              isAuthorized ? HeroIcons.eye : HeroIcons.eyeSlash,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
