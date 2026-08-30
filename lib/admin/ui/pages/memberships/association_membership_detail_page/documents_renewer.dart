import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/memberships/association_membership_members_list_provider.dart';
import 'package:titan/admin/providers/memberships/association_membership_provider.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';

class DocumentsRenewer extends HookConsumerWidget {
  const DocumentsRenewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateController = useTextEditingController();
    final associationMembership = ref.watch(associationMembershipProvider);
    final associationMembershipMemberListNotifier = ref.watch(
      associationMembershipMembersProvider.notifier,
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    useListenable(dateController);
    return Column(
      children: [
        AlignLeftText(
          AdminTextConstants.renewingDocumentsTitle,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: ColorConstants.gradient1,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: DateEntry(
                  label: AdminTextConstants.startDateMinimal,
                  controller: dateController,
                  onTap: () => getOnlyDayDate(
                    context,
                    dateController,
                    firstDate: DateTime(DateTime.now().year),
                    lastDate: DateTime(DateTime.now().year + 7),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: WaitingButton(
                  builder: (child) => AddEditButtonLayout(
                    colors: dateController.text.isEmpty
                        ? [
                            ColorConstants.deactivated1,
                            ColorConstants.deactivated2,
                          ]
                        : [ColorConstants.gradient1, ColorConstants.gradient2],
                    child: child,
                  ),
                  onTap: dateController.text.isEmpty
                      ? () async {}
                      : () async {
                          await showDialog(
                            context: context,
                            builder: ((context) => CustomDialogBox(
                              title: AdminTextConstants.renewingDocumentsTitle,
                              descriptions:
                                  AdminTextConstants
                                      .renewingDocumentsConfirmation1 +
                                  dateController.text +
                                  AdminTextConstants
                                      .renewingDocumentsConfirmation2,
                              onYes: (() async {
                                await tokenExpireWrapper(ref, () async {
                                  final result =
                                      await associationMembershipMemberListNotifier
                                          .renewAssociationMembershipDocuments(
                                            associationMembership.id,
                                            DateTime.parse(
                                              processDateBack(
                                                dateController.text,
                                              ),
                                            ),
                                          );
                                  if (result.errors.isNotEmpty) {
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                      await showDialog(
                                        context: context,
                                        builder: ((context) => CustomDialogBox(
                                          title: AdminTextConstants
                                              .renewingDocumentsTitle,
                                          descriptions: result.errors.entries
                                              .map(
                                                (e) => "${e.key}: ${e.value}",
                                              )
                                              .join("\n"),
                                          onYes: (() {
                                            Navigator.of(context).pop();
                                          }),
                                        )),
                                      );
                                    }
                                  } else {
                                    displayToastWithContext(
                                      TypeMsg.msg,
                                      AdminTextConstants.renewedDocuments,
                                    );
                                  }
                                });
                              }),
                            )),
                          );
                        },
                  child: const Text(
                    AdminTextConstants.renewDocuments,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
