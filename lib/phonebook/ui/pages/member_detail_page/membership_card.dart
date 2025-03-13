import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

class MembershipCard extends HookConsumerWidget {
  const MembershipCard({
    super.key,
    required this.association,
    required this.membership,
    required this.onClicked,
  });

  final AssociationComplete association;
  final VoidCallback onClicked;
  final MembershipComplete membership;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: GestureDetector(
        onTap: onClicked,
        child: CardLayout(
          margin: EdgeInsets.zero,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text(
                "${association.name} - ${membership.mandateYear}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(flex: 1),
              Text(membership.roleName),
            ],
          ),
        ),
      ),
    );
  }
}
