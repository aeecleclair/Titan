import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/admin/admin.dart';
import 'package:titan/admin/class/user_association_membership.dart';
import 'package:titan/admin/class/user_association_membership_base.dart';
import 'package:titan/admin/providers/association_membership_members_list_provider.dart';
import 'package:titan/admin/providers/user_association_membership_provider.dart';
import 'package:titan/admin/ui/pages/membership/add_edit_user_membership_page/user_search_modal.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class AddEditUserMembershipPage extends HookConsumerWidget {
  const AddEditUserMembershipPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);
    final associationMembershipMembersNotifier = ref.watch(
      associationMembershipMembersProvider.notifier,
    );
    final membership = ref.watch(userAssociationMembershipProvider);
    final isEdit = membership.id != UserAssociationMembership.empty().id;
    final start = useTextEditingController(
      text: isEdit ? DateFormat.yMd(locale).format(membership.startDate) : "",
    );
    final end = useTextEditingController(
      text: isEdit ? DateFormat.yMd(locale).format(membership.endDate) : "",
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AdminTemplate(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AlignLeftText(
                isEdit
                    ? AppLocalizations.of(context)!.adminEditMembership
                    : AppLocalizations.of(context)!.adminAddMember,
                fontWeight: FontWeight.w900,
                color: ColorConstants.title,
                fontSize: 24,
              ),
              const SizedBox(height: 20),
              if (!isEdit) ...[
                ListItem(
                  title: membership.user.id.isNotEmpty
                      ? membership.user.getName()
                      : AppLocalizations.of(context)!.adminUser,
                  onTap: () async {
                    await showCustomBottomModal(
                      context: context,
                      ref: ref,
                      modal: UserSearchModal(),
                    );
                  },
                ),
              ] else
                Text(
                  membership.user.getName(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              const SizedBox(height: 10),
              DateEntry(
                label: AppLocalizations.of(context)!.adminStartDate,
                controller: start,
                onTap: () => getOnlyDayDate(
                  context,
                  start,
                  firstDate: DateTime(2019),
                  lastDate: DateTime(2100),
                ),
              ),
              const SizedBox(height: 10),
              DateEntry(
                label: AppLocalizations.of(context)!.adminEndDate,
                controller: end,
                onTap: () => getOnlyDayDate(
                  context,
                  end,
                  firstDate: DateTime(2019),
                  lastDate: DateTime(2100),
                ),
              ),
              const SizedBox(height: 20),
              WaitingButton(
                builder: (child) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstants.tertiary,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: ColorConstants.onTertiary),
                  ),
                  child: Center(child: child),
                ),
                child: Text(
                  !isEdit
                      ? AppLocalizations.of(context)!.adminAdd
                      : AppLocalizations.of(context)!.adminEdit,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                onTap: () async {
                  if (membership.user.id == "") {
                    displayToastWithContext(
                      TypeMsg.msg,
                      AppLocalizations.of(context)!.adminEmptyUser,
                    );
                    return;
                  }
                  if (start.text.isEmpty || end.text.isEmpty) {
                    displayToastWithContext(
                      TypeMsg.msg,
                      AppLocalizations.of(context)!.adminEmptyDate,
                    );
                    return;
                  }

                  tokenExpireWrapper(ref, () async {
                    if (DateTime.parse(
                      processDateBack(start.text, locale.toString()),
                    ).isAfter(DateTime.parse(processDateBack(end.text, locale.toString())))) {
                      displayToastWithContext(
                        TypeMsg.error,
                        AppLocalizations.of(context)!.adminDateError,
                      );
                      return;
                    }
                    if (isEdit) {
                      final updatedMembershipMsg = AppLocalizations.of(
                        context,
                      )!.adminUpdatedMembership;
                      final updatingErrorMsg = AppLocalizations.of(
                        context,
                      )!.adminMembershipUpdatingError;
                      final value = await associationMembershipMembersNotifier
                          .updateMember(
                            membership.copyWith(
                              startDate: DateTime.parse(
                                processDateBack(start.text, locale.toString()),
                              ),
                              endDate: DateTime.parse(
                                processDateBack(end.text, locale.toString()),
                              ),
                            ),
                          );
                      if (value) {
                        displayToastWithContext(
                          TypeMsg.msg,
                          updatedMembershipMsg,
                        );
                        QR.back();
                      } else {
                        displayToastWithContext(
                          TypeMsg.error,
                          updatingErrorMsg,
                        );
                      }
                    } else {
                      // Test if the membership already exists with (association_id,member_id,mandate_year)
                      final membershipAdd = UserAssociationMembershipBase(
                        id: "",
                        associationMembershipId:
                            membership.associationMembershipId,
                        userId: membership.user.id,
                        startDate: DateTime.parse(processDateBack(start.text, locale.toString())),
                        endDate: DateTime.parse(processDateBack(end.text, locale.toString())),
                      );
                      final addedMemberMsg = AppLocalizations.of(
                        context,
                      )!.adminAddedMember;
                      final addingErrorMsg = AppLocalizations.of(
                        context,
                      )!.adminMembershipAddingError;
                      final value = await associationMembershipMembersNotifier
                          .addMember(membershipAdd, membership.user);
                      if (value) {
                        displayToastWithContext(TypeMsg.msg, addedMemberMsg);
                        QR.back();
                      } else {
                        displayToastWithContext(TypeMsg.error, addingErrorMsg);
                      }
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
