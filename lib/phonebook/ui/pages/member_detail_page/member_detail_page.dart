import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/complete_member_provider.dart';
import 'package:titan/phonebook/providers/member_pictures_provider.dart';
import 'package:titan/phonebook/providers/profile_picture_provider.dart';
import 'package:titan/phonebook/ui/pages/member_detail_page/membership_card.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';

class MemberDetailPage extends HookConsumerWidget {
  const MemberDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final member = ref.watch(completeMemberProvider);
    final associationList = ref.watch(associationListProvider);
    final memberPictures = ref.watch(
      memberPicturesProvider.select((value) => value[member]),
    );
    final memberPicturesNotifier = ref.watch(memberPicturesProvider.notifier);
    final profilePictureNotifier = ref.watch(profilePictureProvider.notifier);

    AppLocalizations localizeWithContext = AppLocalizations.of(context)!;

    final sortedMemberships = [...member.memberships];
    sortedMemberships.sort((a, b) => a.mandateYear.compareTo(b.mandateYear));

    return PhonebookTemplate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    AutoLoaderChild(
                      group: memberPictures,
                      notifier: memberPicturesNotifier,
                      mapKey: member,
                      loader: (ref) => profilePictureNotifier.getProfilePicture(
                        member.member.id,
                      ),
                      loadingBuilder: (context) => const CircleAvatar(
                        radius: 80,
                        child: CircularProgressIndicator(),
                      ),
                      dataBuilder: (context, data) => CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        backgroundImage: Image(image: data.first.image).image,
                      ),
                    ),
                    if (member.member.nickname != null) ...[
                      Text(
                        member.member.nickname!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        member.getName(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ] else
                      Text(
                        member.getName(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 5),
                    if (member.member.promotion != 0)
                      Text(
                        localizeWithContext.phonebookPromotion(
                          member.member.promotion < 100
                              ? member.member.promotion + 2000
                              : member.member.promotion,
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                    const SizedBox(height: 20),
                    Text(
                      member.member.email,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    if (member.member.phone != null)
                      Text(
                        member.member.phone!,
                        style: const TextStyle(fontSize: 16),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (member.memberships.isNotEmpty)
                Text(
                  member.memberships.length == 1
                      ? localizeWithContext.phonebookAssociation
                      : localizeWithContext.phonebookAssociations,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 10),
              AsyncChild(
                value: associationList,
                builder: (context, associations) => Column(
                  children: [
                    ...sortedMemberships.map((membership) {
                      final membershipAssociation = associations.firstWhere(
                        (association) =>
                            association.id == membership.associationId,
                      );
                      return MembershipCard(
                        association: membershipAssociation,
                        membership: membership,
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
