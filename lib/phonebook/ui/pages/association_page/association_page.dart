import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/member.dart';
import 'package:myecl/phonebook/class/post.dart';
import 'package:myecl/phonebook/class/role.dart';
import 'package:myecl/phonebook/providers/association_picture_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/ui/pages/association_page/member_card.dart';

class AssociationPage extends HookConsumerWidget {
  const AssociationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final association = ref.watch(associationProvider);
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    final associationPicture = ref.watch(associationPictureProvider);
    final associationMemberList = ref.watch(associationMemberListProvider);

    return Column(children: [
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
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: associationMemberList.when(
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
              List<CompleteMember> members = [
                CompleteMember(
                  member: Member(name: 'Dupond', firstname: 'Michel', nickname: 'Testouille', id: '1', email: 'test1@useless'),
                  post: [Post(association: association, role: Role(id: '1', name: 'Prez\''))]),
                  CompleteMember(
                  member: Member(name: 'Debouck', firstname: 'Frank', nickname: 'Chad', id: '2', email: 'test2@useless'),
                  post: [Post(association: association, role: Role(id: '2', name: 'Trez\''))]),
                  CompleteMember(
                  member: Member(name: 'Ray', firstname: 'Pascal', nickname: 'Salut', id: '3', email: 'test3@useless'),
                  post: [Post(association: association, role: Role(id: '3', name: 'SG'))]),
                  CompleteMember(
                  member: Member(name: 'Guarriguenc', firstname: 'Jean-Luc', nickname: 'Cascouille', id: '4', email: 'test4@useless'),
                  post: [Post(association: association, role: Role(id: '4', name: 'Fillot')),
                         Post(association: Association(id: '12',name: 'testTest', description: 'JSP frère'),
                          role: Role(id: '5', name: 'Bourrin'))]),
              ];
              return Column(
                children: members.map((member) => 
                  MemberCard(member: member)
                ).toList()
              );
            },
          )
      ),
    ]);
  }
}
