import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/admin.dart';
import 'package:titan/admin/providers/research_filter_provider.dart';
import 'package:titan/admin/router.dart';
import 'package:titan/admin/class/user_association_membership.dart';
import 'package:titan/admin/providers/association_membership_filtered_members_provider.dart';
import 'package:titan/admin/providers/association_membership_members_list_provider.dart';
import 'package:titan/admin/providers/association_membership_provider.dart';
import 'package:titan/admin/providers/user_association_membership_provider.dart';
import 'package:titan/admin/ui/pages/membership/association_membership_detail_page/association_membership_information_editor.dart';
import 'package:titan/admin/ui/pages/membership/association_membership_detail_page/association_membership_member_editable_card.dart';
import 'package:titan/admin/ui/pages/membership/association_membership_detail_page/search_filters.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';

class AssociationMembershipEditorPage extends HookConsumerWidget {
  final scrollKey = GlobalKey();
  AssociationMembershipEditorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterNotifier = ref.watch(filterProvider.notifier);
    final associationMembership = ref.watch(associationMembershipProvider);
    final associationMembershipMemberListNotifier = ref.watch(
      associationMembershipMembersProvider.notifier,
    );
    final userAssociationMembershipNotifier = ref.watch(
      userAssociationMembershipProvider.notifier,
    );
    final associationMembershipFilteredList = ref.watch(
      associationMembershipFilteredListProvider,
    );

    return AdminTemplate(
      child: Refresher(
        controller: ScrollController(),
        onRefresh: () async {
          await associationMembershipMemberListNotifier
              .loadAssociationMembershipMembers(associationMembership.id);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${AppLocalizations.of(context)!.adminAssociationMembership} ${associationMembership.name}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.title,
                  ),
                ),
              ),
              AssociationMembershipInformationEditor(),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "${AppLocalizations.of(context)!.adminMembers} (${associationMembershipFilteredList.length})",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.title,
                    ),
                  ),
                  const Spacer(),
                  CustomIconButton(
                    onPressed: () async {
                      userAssociationMembershipNotifier
                          .setUserAssociationMembership(
                            UserAssociationMembership.empty().copyWith(
                              associationMembershipId: associationMembership.id,
                            ),
                          );
                      QR.to(
                        AdminRouter.root +
                            AdminRouter.associationMemberships +
                            AdminRouter.detailAssociationMembership +
                            AdminRouter.addEditMember,
                      );
                    },
                    icon: const HeroIcon(
                      HeroIcons.plus,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ListItem(
                title: AppLocalizations.of(context)!.adminFilters,
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  final ctx = context;
                  await Future.delayed(Duration(milliseconds: 150));
                  if (!ctx.mounted) return;

                  await showCustomBottomModal(
                    context: ctx,
                    ref: ref,
                    modal: BottomModalTemplate(
                      title: AppLocalizations.of(context)!.adminFilters,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SearchFilters(),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              CustomSearchBar(
                onSearch: (query) {
                  filterNotifier.setFilter(query);
                },
              ),
              const SizedBox(height: 10),
              associationMembershipFilteredList.isEmpty
                  ? Text(AppLocalizations.of(context)!.adminNoMember)
                  : SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: associationMembershipFilteredList.length,
                        itemBuilder: (context, index) {
                          return MemberEditableCard(
                            key: ValueKey(
                              associationMembershipFilteredList[index].user.id,
                            ),
                            associationMembership:
                                associationMembershipFilteredList[index],
                          );
                        },
                      ),
                    ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
