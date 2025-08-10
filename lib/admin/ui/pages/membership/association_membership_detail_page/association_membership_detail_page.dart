import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/admin.dart';
import 'package:titan/admin/router.dart';
import 'package:titan/admin/class/user_association_membership.dart';
import 'package:titan/admin/providers/association_membership_filtered_members_provider.dart';
import 'package:titan/admin/providers/association_membership_members_list_provider.dart';
import 'package:titan/admin/providers/association_membership_provider.dart';
import 'package:titan/admin/providers/user_association_membership_provider.dart';
import 'package:titan/admin/ui/pages/membership/association_membership_detail_page/association_membership_information_editor.dart';
import 'package:titan/admin/ui/pages/membership/association_membership_detail_page/association_membership_member_editable_card.dart';
import 'package:titan/admin/ui/pages/membership/association_membership_detail_page/research_bar.dart';
import 'package:titan/admin/ui/pages/membership/association_membership_detail_page/search_filters.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class AssociationMembershipEditorPage extends HookConsumerWidget {
  final scrollKey = GlobalKey();
  AssociationMembershipEditorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        onRefresh: () async {
          await associationMembershipMemberListNotifier
              .loadAssociationMembershipMembers(associationMembership.id);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${AppLocalizations.of(context)!.adminAssociationMembership} ${associationMembership.name}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.main,
                  ),
                ),
              ),
              AssociationMembershipInformationEditor(),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.adminMembers,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.main,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "(${associationMembershipFilteredList.length} ${AppLocalizations.of(context)!.adminMembers})",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.main,
                    ),
                  ),
                  const Spacer(),
                  WaitingButton(
                    builder: (child) => Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.main,
                      ),
                      child: child,
                    ),
                    onTap: () async {
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
                    child: const HeroIcon(
                      HeroIcons.plus,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ExpansionTile(
                title: Text(AppLocalizations.of(context)!.adminFilters),
                children: const [SearchFilters()],
              ),
              const SizedBox(height: 20),
              ResearchBar(),
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
