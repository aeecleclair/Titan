import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/all_groups_list_provider.dart';
import 'package:titan/admin/providers/user_invitation_provider.dart';
import 'package:titan/admin/tools/functions.dart' as admin_utils;
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/paiement/ui/pages/main_page/account_card/device_dialog_box.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';

class AddUsersModalContent extends HookConsumerWidget {
  const AddUsersModalContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(allGroupList);
    final selectedFileName = useState<String?>(null);
    final mailList = useState<List<String>>([]);
    final chosenGroup = useState<SimpleGroup?>(null);
    final userInvitationNotifier = ref.watch(userInvitationProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final localizeWithContext = AppLocalizations.of(context)!;

    final navigatorWithContext = Navigator.of(context);

    return BottomModalTemplate(
      title: localizeWithContext.adminInviteUsers,
      child: Column(
        children: [
          Text(
            localizeWithContext.adminImportUsersDescription,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Button.secondary(
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
                  String fileContent = '';
                  if (kIsWeb) {
                    fileContent = file.bytes != null
                        ? String.fromCharCodes(file.bytes!)
                        : '';
                  } else {
                    fileContent = await File(file.path!).readAsString();
                  }
                  mailList.value = admin_utils.parseCsvContent(fileContent);
                }
              }
            },
          ),
          const SizedBox(height: 20),
          Text(
            localizeWithContext.adminInviteUsersCounter(mailList.value.length),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 30),
          ListItem(
            title: chosenGroup.value?.name ?? localizeWithContext.adminNoGroup,
            onTap: () async {
              FocusScope.of(context).unfocus();
              final ctx = context;
              await Future.delayed(Duration(milliseconds: 150));
              if (!ctx.mounted) return;

              await showCustomBottomModal(
                context: ctx,
                ref: ref,
                modal: BottomModalTemplate(
                  title: localizeWithContext.adminChooseGroup,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 600),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...groups.map(
                            (e) => ListItem(
                              title: e.name,
                              onTap: () {
                                chosenGroup.value = e;
                                Navigator.of(ctx).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          WaitingButton(
            builder: (child) => Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: ColorConstants.tertiary,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorConstants.onTertiary),
              ),
              child: Center(child: child),
            ),
            onTap: () async {
              if (selectedFileName.value == null) return;
              await tokenExpireWrapper(ref, () async {
                final value = await userInvitationNotifier.createUsers(
                  mailList.value,
                  chosenGroup.value?.id,
                );
                if (value.isEmpty) {
                  displayToastWithContext(
                    TypeMsg.msg,
                    localizeWithContext.adminInvitedUsers,
                  );
                  navigatorWithContext.pop();
                } else {
                  if (!context.mounted) return;
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) => DeviceDialogBox(
                      descriptions: value.map((e) => '- $e').join('\n'),
                      title: AppLocalizations.of(context)!.adminEmailFailed,
                      buttonText: "Compris",
                      onClick: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                }
              });
            },
            child: Text(
              localizeWithContext.adminInvite,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(
                  255,
                  255,
                  255,
                  255,
                ).withAlpha(selectedFileName.value == null ? 100 : 255),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
