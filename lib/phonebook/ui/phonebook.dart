import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class PhonebookTemplate extends HookConsumerWidget {
  final Widget child;
  const PhonebookTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationGroupementNotifer = ref.watch(
      associationGroupementProvider.notifier,
    );
    return Container(
      color: ColorConstants.background,
      child: SafeArea(
        child: Column(
          children: [
            TopBar(
              root: PhonebookRouter.root,
              onBack: () {
                if (QR.currentPath !=
                    PhonebookRouter.root +
                        PhonebookRouter.admin +
                        PhonebookRouter.editAssociationMembers +
                        PhonebookRouter.addEditMember) {
                  associationGroupementNotifer.resetAssociationGroupement();
                }
              },
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
