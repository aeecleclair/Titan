import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/admin.dart';
import 'package:titan/admin/providers/group_list_provider.dart';
import 'package:titan/admin/repositories/notification_repository.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class GroupNotificationPage extends HookConsumerWidget {
  const GroupNotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(allGroupListProvider);
    final groupsNotifier = ref.watch(allGroupListProvider.notifier);
    final notificationRepository = ref.watch(notificationRepositoryProvider);
    final titleController = useTextEditingController();
    final contentController = useTextEditingController();
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final localizeWithContext = AppLocalizations.of(context)!;
    return AdminTemplate(
      child: Refresher(
        onRefresh: () async {
          await groupsNotifier.loadGroups();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  localizeWithContext.adminGroupNotification,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.title,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              AsyncChild(
                value: groups,
                builder: (context, g) {
                  g.sort(
                    (a, b) =>
                        a.name.toLowerCase().compareTo(b.name.toLowerCase()),
                  );
                  return Column(
                    children: [
                      Column(
                        children: [
                          ...g.map(
                            (group) => ListItem(
                              title: group.name,
                              subtitle: group.description,
                              onTap: () async {
                                await showCustomBottomModal(
                                  context: context,
                                  ref: ref,
                                  modal: BottomModalTemplate(
                                    title: localizeWithContext.adminNotifyGroup(
                                      group.name,
                                    ),
                                    child: Column(
                                      children: [
                                        TextEntry(
                                          label: localizeWithContext.adminTitle,
                                          controller: titleController,
                                        ),
                                        const SizedBox(height: 20),
                                        TextEntry(
                                          label:
                                              localizeWithContext.adminContent,
                                          controller: contentController,
                                          maxLines: 5,
                                        ),
                                        const SizedBox(height: 20),
                                        Button(
                                          text: localizeWithContext.adminSend,
                                          onPressed: () {
                                            notificationRepository
                                                .sendNotification(
                                                  group.id,
                                                  titleController.text,
                                                  contentController.text,
                                                )
                                                .then((value) {
                                                  if (value) {
                                                    displayToastWithContext(
                                                      TypeMsg.msg,
                                                      localizeWithContext
                                                          .adminNotificationSent,
                                                    );
                                                  } else {
                                                    displayToastWithContext(
                                                      TypeMsg.error,
                                                      localizeWithContext
                                                          .adminFailedToSendNotification,
                                                    );
                                                  }
                                                })
                                                .catchError((error) {
                                                  displayToastWithContext(
                                                    TypeMsg.error,
                                                    error.toString(),
                                                  );
                                                });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  );
                },
                loaderColor: ColorConstants.main,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
