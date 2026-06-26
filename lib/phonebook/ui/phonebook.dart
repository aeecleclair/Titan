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

    final pathGroupementClearing = [
      PhonebookRouter.root + PhonebookRouter.admin,
      PhonebookRouter.root + PhonebookRouter.associationDetail,
      PhonebookRouter.root +
          PhonebookRouter.admin +
          PhonebookRouter.addEditAssociation,
      PhonebookRouter.root +
          PhonebookRouter.admin +
          PhonebookRouter.editAssociationGroups,
      PhonebookRouter.root +
          PhonebookRouter.admin +
          PhonebookRouter.editAssociationMembers,
    ];

    return Container(
      color: ColorConstants.background,
      child: SafeArea(
        child: Column(
          children: [
            TopBar(
              root: PhonebookRouter.root,
              onBack: () {
                if (pathGroupementClearing.contains(QR.currentPath)) {
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
