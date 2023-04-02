import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/providers/association_picture_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/tools/fake_class.dart';
import 'package:myecl/phonebook/ui/pages/association_page/member_card.dart';
import 'package:myecl/tools/ui/refresher.dart';

class AssociationPage extends HookConsumerWidget {

  const AssociationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final association = ref.watch(associationProvider);
    final associationPicture = ref.watch(associationPictureProvider);
    final associationMemberList = ref.watch(associationMemberListProvider);
    final associationMemberListNotifier = ref.watch(associationMemberListProvider.notifier);
    final associationPictureNotifier = ref.watch(associationPictureProvider.notifier); 


    return Refresher(
      onRefresh : () async {
        await associationMemberListNotifier.loadMembers(association.id);
        await associationPictureNotifier.getAssociationPicture(association.id);
      },
      child: Column(
        children: [
        const Text(PhonebookTextConstants.associationDetail),
        const SizedBox(height: 20,),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(2, 3),
              ),
            ],
          ),
          child: associationPicture.when(
            data: (picture) {
              return CircleAvatar(
                radius: 80,
                backgroundImage: picture.isEmpty
                    ? const AssetImage('assets/images/logo_alpha.png')
                    : Image.memory(picture).image,
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (e, s) {
              return const Center(
                child: Text(PhonebookTextConstants.errorLoadAssociationPicture),
              );
            },
          ),
        ),
        const SizedBox(height: 20,),
        Text(association.name,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black
          ),
        ),
        const SizedBox(height: 10,),
        Text(association.description,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black
          ),
        ),
        const SizedBox(height: 20,),
        associationMemberList.when(
          data: (members) {
            return Column(
              children: members.map((member) => 
                MemberCard(member: member)
              ).toList()
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          error: (e, s) {
            //return const Center(
            //  child: Text(PhonebookTextConstants.errorLoadAssociationMember),
            List<CompleteMember> fakeMembers = [CompleteMember.empty()];
            return Column(
              children: fakeMembers.map((member) => 
                MemberCard(member: member)
              ).toList()
            );
          },
        )
    ]));
  }
}
