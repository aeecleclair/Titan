import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';

class UsersManagementPage extends HookConsumerWidget {
  const UsersManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Button(
          text: 'Ajouter',
          onPressed: () async {
            Navigator.pop(context);
            await showCustomBottomModal(
              context: context,
              ref: ref,
              modal: BottomModalTemplate(
                title: "Ajouter des utilisateurs",
                child: Column(
                  children: [
                    Button(text: "Importer une liste", onPressed: () {}),
                    const SizedBox(height: 20),
                    Button(text: "Ajouter", onPressed: () {}, disabled: true),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        Button(
          text: 'Supprimer',
          onPressed: () async {
            Navigator.pop(context);
            await showCustomBottomModal(
              context: context,
              ref: ref,
              modal: BottomModalTemplate(
                type: BottomModalType.danger,
                title: "Supprimer des utilisateurs",
                child: Column(
                  children: [
                    Button(
                      text: "Importer une liste",
                      onPressed: () {},
                      type: ButtonType.onDanger,
                    ),
                    const SizedBox(height: 20),
                    Button(text: "Supprimer", onPressed: () {}, disabled: true),
                  ],
                ),
              ),
            );
          },
          type: ButtonType.danger,
        ),
      ],
    );
  }
}
