import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/ui/pages/users_management_page/add_user_modal.dart';
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
              modal: AddUsersModalContent(),
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
