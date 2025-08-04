import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/association_membership_simple.dart';
import 'package:titan/admin/providers/all_groups_list_provider.dart';
import 'package:titan/admin/providers/association_membership_list_provider.dart';
import 'package:titan/super_admin/providers/association_membership_members_list_provider.dart';
import 'package:titan/super_admin/providers/association_membership_provider.dart';
import 'package:titan/super_admin/router.dart';
import 'package:titan/super_admin/ui/admin.dart';
import 'package:titan/super_admin/ui/components/item_card_ui.dart';
import 'package:titan/super_admin/ui/pages/memberships/association_membership_page/association_membership_creation_dialog.dart';
import 'package:titan/super_admin/ui/pages/memberships/association_membership_page/association_membership_ui.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class AssociationMembershipsPage extends HookConsumerWidget {
  const AssociationMembershipsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationsMemberships = ref.watch(
      allAssociationMembershipListProvider,
    );
    final associationMembershipsNotifier = ref.watch(
      allAssociationMembershipListProvider.notifier,
    );
    final associationMembershipNotifier = ref.watch(
      associationMembershipProvider.notifier,
    );
    final associationMembershipMembersNotifier = ref.watch(
      associationMembershipMembersProvider.notifier,
    );
    final groups = ref.watch(allGroupList);

    final nameController = TextEditingController();
    final groupIdController = TextEditingController();
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SuperAdminTemplate(
      child: Refresher(
        onRefresh: () async {
          await associationMembershipsNotifier.loadAssociationMemberships();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.adminAssociationsMemberships,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.gradient1,
                  ),
                ),
              ),
              SizedBox(height: 30),
              AsyncChild(
                value: associationsMemberships,
                builder: (context, g) {
                  g.sort(
                    (a, b) =>
                        a.name.toLowerCase().compareTo(b.name.toLowerCase()),
                  );
                  return Column(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return MembershipCreationDialogBox(
                                    groups: groups,
                                    nameController: nameController,
                                    groupIdController: groupIdController,
                                    onYes: () async {
                                      final createdAssociationMembershipMsg =
                                          AppLocalizations.of(
                                            context,
                                          )!.adminCreatedAssociationMembership;
                                      final creationErrorMsg =
                                          AppLocalizations.of(
                                            context,
                                          )!.adminCreationError;
                                      tokenExpireWrapper(ref, () async {
                                        final value =
                                            await associationMembershipsNotifier
                                                .createAssociationMembership(
                                                  AssociationMembership.empty()
                                                      .copyWith(
                                                        managerGroupId:
                                                            groupIdController
                                                                .text,
                                                        name:
                                                            nameController.text,
                                                      ),
                                                );
                                        if (value) {
                                          displayToastWithContext(
                                            TypeMsg.msg,
                                            createdAssociationMembershipMsg,
                                          );
                                        } else {
                                          displayToastWithContext(
                                            TypeMsg.error,
                                            creationErrorMsg,
                                          );
                                        }
                                      });
                                    },
                                  );
                                },
                              );
                            },
                            child: ItemCardUi(
                              children: [
                                const Spacer(),
                                HeroIcon(
                                  HeroIcons.plus,
                                  color: Colors.grey.shade700,
                                  size: 40,
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          ...g.map(
                            (associationMembership) => AssociationMembershipUi(
                              associationMembership: associationMembership,
                              onEdit: () {
                                associationMembershipMembersNotifier
                                    .loadAssociationMembershipMembers(
                                      associationMembership.id,
                                    );
                                associationMembershipNotifier
                                    .setAssociationMembership(
                                      associationMembership,
                                    );
                                QR.to(
                                  SuperAdminRouter.root +
                                      SuperAdminRouter.associationMemberships +
                                      SuperAdminRouter
                                          .detailAssociationMembership,
                                );
                              },
                              onDelete: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                      title: AppLocalizations.of(
                                        context,
                                      )!.adminDeleting,
                                      descriptions: AppLocalizations.of(
                                        context,
                                      )!.adminDeleteAssociationMembership,
                                      onYes: () async {
                                        tokenExpireWrapper(ref, () async {
                                          final deletedAssociationMembershipMsg =
                                              AppLocalizations.of(
                                                context,
                                              )!.adminDeletedAssociationMembership;
                                          final deletingErrorMsg =
                                              AppLocalizations.of(
                                                context,
                                              )!.adminDeletingError;
                                          final value =
                                              await associationMembershipsNotifier
                                                  .deleteAssociationMembership(
                                                    associationMembership,
                                                  );
                                          if (value) {
                                            displayToastWithContext(
                                              TypeMsg.msg,
                                              deletedAssociationMembershipMsg,
                                            );
                                          } else {
                                            displayToastWithContext(
                                              TypeMsg.error,
                                              deletingErrorMsg,
                                            );
                                          }
                                        });
                                      },
                                    );
                                  },
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
                loaderColor: ColorConstants.gradient1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
