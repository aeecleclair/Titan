import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/ui/pages/users_management_page/add_user_modal.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';

class UsersManagementPage extends HookConsumerWidget {
  const UsersManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizeWithContext = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Button(
          text: localizeWithContext.adminEdit,
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
          text: localizeWithContext.adminDelete,
          onPressed: () async {
            Navigator.pop(context);
            await showCustomBottomModal(
              context: context,
              ref: ref,
              modal: BottomModalTemplate(
                type: BottomModalType.danger,
                title: localizeWithContext.adminDeleteUsers,
                child: Column(
                  children: [
                    Button(
                      text: localizeWithContext.adminImportList,
                      onPressed: () {},
                      type: ButtonType.onDanger,
                    ),
                    const SizedBox(height: 20),
                    Button(
                      text: localizeWithContext.adminDelete,
                      onPressed: () {},
                      disabled: true,
                    ),
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
