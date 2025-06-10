import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/user_association_membership.dart';
import 'package:titan/admin/class/user_association_membership_base.dart';
import 'package:titan/admin/providers/association_membership_members_list_provider.dart';
import 'package:titan/admin/providers/user_association_membership_provider.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/admin/ui/admin.dart';
import 'package:titan/admin/ui/pages/memberships/add_edit_user_membership_page/search_result.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/widgets/styled_search_bar.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditUserMembershipPage extends HookConsumerWidget {
  const AddEditUserMembershipPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationMembershipMembersNotifier = ref.watch(
      associationMembershipMembersProvider.notifier,
    );
    final queryController = useTextEditingController(text: '');
    final usersNotifier = ref.watch(userList.notifier);
    final membership = ref.watch(userAssociationMembershipProvider);
    final isEdit = membership.id != UserAssociationMembership.empty().id;
    final start = useTextEditingController(
      text: isEdit ? processDate(membership.startDate) : "",
    );
    final end = useTextEditingController(
      text: isEdit ? processDate(membership.endDate) : "",
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AdminTemplate(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AlignLeftText(
                isEdit
                    ? AdminTextConstants.editMembership
                    : AdminTextConstants.addMember,
              ),
              const SizedBox(height: 20),
              if (!isEdit) ...[
                StyledSearchBar(
                  padding: EdgeInsets.zero,
                  label: AdminTextConstants.user,
                  editingController: queryController,
                  onChanged: (value) async {
                    tokenExpireWrapper(ref, () async {
                      if (value.isNotEmpty) {
                        await usersNotifier.filterUsers(value);
                      } else {
                        usersNotifier.clear();
                      }
                    });
                  },
                ),
                SearchResult(queryController: queryController),
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
                label: AdminTextConstants.startDate,
                controller: start,
                onTap: () => getOnlyDayDate(
                  context,
                  start,
                  firstDate: DateTime(2019),
                  lastDate: DateTime(2100),
                ),
              ),
              const SizedBox(height: 50),
              DateEntry(
                label: AdminTextConstants.endDate,
                controller: end,
                onTap: () => getOnlyDayDate(
                  context,
                  end,
                  firstDate: DateTime(2019),
                  lastDate: DateTime(2100),
                ),
              ),
              const SizedBox(height: 50),
              WaitingButton(
                builder: (child) => AddEditButtonLayout(
                  colors: const [
                    ColorConstants.gradient1,
                    ColorConstants.gradient2,
                  ],
                  child: child,
                ),
                child: Text(
                  !isEdit ? AdminTextConstants.add : AdminTextConstants.edit,
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
                      AdminTextConstants.emptyUser,
                    );
                    return;
                  }
                  if (start.text.isEmpty || end.text.isEmpty) {
                    displayToastWithContext(
                      TypeMsg.msg,
                      AdminTextConstants.emptyDate,
                    );
                    return;
                  }

                  tokenExpireWrapper(ref, () async {
                    if (DateTime.parse(
                      processDateBack(start.text),
                    ).isAfter(DateTime.parse(processDateBack(end.text)))) {
                      displayToastWithContext(
                        TypeMsg.error,
                        AdminTextConstants.dateError,
                      );
                      return;
                    }
                    if (isEdit) {
                      final value = await associationMembershipMembersNotifier
                          .updateMember(
                            membership.copyWith(
                              startDate: DateTime.parse(
                                processDateBack(start.text),
                              ),
                              endDate: DateTime.parse(
                                processDateBack(end.text),
                              ),
                            ),
                          );
                      if (value) {
                        displayToastWithContext(
                          TypeMsg.msg,
                          AdminTextConstants.updatedMembership,
                        );
                        QR.back();
                      } else {
                        displayToastWithContext(
                          TypeMsg.error,
                          AdminTextConstants.membershipUpdatingError,
                        );
                      }
                    } else {
                      // Test if the membership already exists with (association_id,member_id,mandate_year)
                      final membershipAdd = UserAssociationMembershipBase(
                        id: "",
                        associationMembershipId:
                            membership.associationMembershipId,
                        userId: membership.user.id,
                        startDate: DateTime.parse(processDateBack(start.text)),
                        endDate: DateTime.parse(processDateBack(end.text)),
                      );
                      final value = await associationMembershipMembersNotifier
                          .addMember(membershipAdd, membership.user);
                      if (value) {
                        displayToastWithContext(
                          TypeMsg.msg,
                          AdminTextConstants.addedMember,
                        );
                        QR.back();
                      } else {
                        displayToastWithContext(
                          TypeMsg.error,
                          AdminTextConstants.membershipAddingError,
                        );
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
