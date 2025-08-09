import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/user_creation_provider.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';

class AddUsersModalContent extends HookConsumerWidget {
  const AddUsersModalContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFileName = useState<String?>(null);
    final mailList = useState<List<String>>([]);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final localizeWithContext = AppLocalizations.of(context)!;

    return BottomModalTemplate(
      title: localizeWithContext.adminInviteUsers,
      child: Column(
        children: [
          Button(
            text: selectedFileName.value ?? localizeWithContext.adminImportList,
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['csv'],
              );
              if (result != null && result.files.isNotEmpty) {
                final file = result.files.first;

                selectedFileName.value = file.name;

                if (file.path != null) {
                  final fileContent = await File(file.path!).readAsString();

                  final lines = fileContent.split('\n');
                  final List<String> emails = [];

                  for (var i = 0; i < lines.length; i++) {
                    final line = lines[i].trim();
                    if (line.isEmpty) continue;

                    final columns = line.split(',');

                    final email = columns[0].trim();

                    if (email.contains('@')) {
                      emails.add(email);
                    }
                  }
                  mailList.value = emails;
                }
              }
            },
          ),
          const SizedBox(height: 20),
          Button(
            text: localizeWithContext.adminAdd,
            onPressed: () {
              tokenExpireWrapper(ref, () async {
                final userCreationNotifier = ref.watch(
                  userCreationProvider.notifier,
                );
                final value = await userCreationNotifier.createUsers(
                  mailList.value,
                );
                if (value) {
                  displayToastWithContext(
                    TypeMsg.msg,
                    localizeWithContext.adminInvitedUsers,
                  );
                } else {
                  displayToastWithContext(
                    TypeMsg.error,
                    localizeWithContext.adminFailedToInviteUsers,
                  );
                }
                // popWithContext();
              });
            },
            disabled: selectedFileName.value == null,
          ),
        ],
      ),
    );
  }
}
