import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/providers/association_kind_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhonebookTemplate extends HookConsumerWidget {
  final Widget child;
  const PhonebookTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kindNotifier = ref.watch(associationKindProvider.notifier);
    return SafeArea(
      child: Column(
        children: [
          TopBar(
            title: PhonebookTextConstants.phonebook,
            root: PhonebookRouter.root,
            onBack: () {
              if (QR.currentPath !=
                  PhonebookRouter.root +
                      PhonebookRouter.admin +
                      PhonebookRouter.editAssociation +
                      PhonebookRouter.addEditMember) {
                kindNotifier.setKind('');
              }
              if (QR.currentPath ==
                  PhonebookRouter.root +
                      PhonebookRouter.admin +
                      PhonebookRouter.editAssociation) {
                QR.to(
                  PhonebookRouter.root + PhonebookRouter.admin,
                ); // Used on back after adding an association
              }
            },
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
