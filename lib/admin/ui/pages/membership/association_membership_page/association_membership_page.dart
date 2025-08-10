import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/admin.dart';
import 'package:titan/admin/class/association_membership_simple.dart';
import 'package:titan/admin/providers/all_groups_list_provider.dart';
import 'package:titan/admin/providers/association_membership_list_provider.dart';
import 'package:titan/admin/router.dart';
import 'package:titan/admin/ui/pages/membership/association_membership_page/add_membership_modal.dart';
import 'package:titan/admin/providers/association_membership_members_list_provider.dart';
import 'package:titan/admin/providers/association_membership_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
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

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    void popWithContext() {
      Navigator.of(context).pop();
    }

    final localizeWithContext = AppLocalizations.of(context)!;

    return AdminTemplate(
      child: Refresher(
        controller: ScrollController(),
        onRefresh: () async {
          await associationMembershipsNotifier.loadAssociationMemberships();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.adminAssociationMembership,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  CustomIconButton(
                    icon: HeroIcon(
                      HeroIcons.plus,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () async {
                      await showCustomBottomModal(
                        context: context,
                        ref: ref,
                        modal: AddMembershipModal(
                          ref: ref,
                          groups: groups,
                          onSubmit: (group, name) {
                            tokenExpireWrapper(ref, () async {
                              final value = await associationMembershipsNotifier
                                  .createAssociationMembership(
                                    AssociationMembership.empty().copyWith(
                                      managerGroupId: group.id,
                                      name: name,
                                    ),
                                  );
                              if (value) {
                                displayToastWithContext(
                                  TypeMsg.msg,
                                  localizeWithContext
                                      .adminCreatedAssociationMembership,
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  localizeWithContext.adminCreationError,
                                );
                              }
                              popWithContext();
                            });
                          },
                        ),
                      );
                    },
                  ),
                ],
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
                          ...g.map(
                            (associationMembership) => ListItem(
                              title: associationMembership.name,
                              onTap: () async {
                                await showCustomBottomModal(
                                  context: context,
                                  ref: ref,
                                  modal: BottomModalTemplate(
                                    title: associationMembership.name,
                                    child: Column(
                                      children: [
                                        Button(
                                          text: localizeWithContext.adminEdit,
                                          onPressed: () {
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
                                                  AdminRouter
                                                      .associationMemberships +
                                                  AdminRouter
                                                      .detailAssociationMembership,
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                        Button(
                                          text: localizeWithContext.adminDelete,
                                          type: ButtonType.danger,
                                          onPressed: () async {
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
