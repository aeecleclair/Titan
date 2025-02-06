import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/association_membership_simple.dart';
import 'package:myecl/admin/providers/association_membership_list_provider.dart';
import 'package:myecl/admin/providers/association_membership_members_list_provider.dart';
import 'package:myecl/admin/providers/association_membership_provider.dart';
import 'package:myecl/admin/router.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/admin/ui/components/item_card_ui.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/pages/memberships/association_membership_page/association_membership_creation_dialog.dart';
import 'package:myecl/admin/ui/pages/memberships/association_membership_page/association_membership_ui.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AssociationMembershipsPage extends HookConsumerWidget {
  const AssociationMembershipsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationsMemberships =
        ref.watch(allAssociationMembershipListProvider);
    final associationMembershipsNotifier =
        ref.watch(allAssociationMembershipListProvider.notifier);
    final associationMembershipNotifier =
        ref.watch(associationMembershipProvider.notifier);
    final associationMembershipMembersNotifier =
        ref.watch(associationMembershipMembersProvider.notifier);
    ref.watch(userList);

    final controller = TextEditingController();
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AdminTemplate(
      child: Refresher(
        onRefresh: () async {
          await associationMembershipsNotifier.loadAssociationMemberships();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AdminTextConstants.associationsMemberships,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.gradient1,
                  ),
                ),
              ),
              const SizedBox(height: 30),
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
                                    controller: controller,
                                    onYes: () async {
                                      tokenExpireWrapper(ref, () async {
                                        final value =
                                            await associationMembershipsNotifier
                                                .createAssociationMembership(
                                          AssociationMembership.empty()
                                              .copyWith(
                                            name: controller.text,
                                          ),
                                        );
                                        if (value) {
                                          displayToastWithContext(
                                            TypeMsg.msg,
                                            AdminTextConstants
                                                .createdAssociationMembership,
                                          );
                                        } else {
                                          displayToastWithContext(
                                            TypeMsg.error,
                                            AdminTextConstants.creationError,
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
                                  AdminRouter.root +
                                      AdminRouter.associationMemberships +
                                      AdminRouter.detailAssociationMembership,
                                );
                              },
                              onDelete: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                      title: AdminTextConstants.deleting,
                                      descriptions: AdminTextConstants
                                          .deleteAssociationMembership,
                                      onYes: () async {
                                        tokenExpireWrapper(ref, () async {
                                          final value =
                                              await associationMembershipsNotifier
                                                  .deleteAssociationMembership(
                                            associationMembership,
                                          );
                                          if (value) {
                                            displayToastWithContext(
                                              TypeMsg.msg,
                                              AdminTextConstants
                                                  .deletedAssociationMembership,
                                            );
                                          } else {
                                            displayToastWithContext(
                                              TypeMsg.error,
                                              AdminTextConstants.deletingError,
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
