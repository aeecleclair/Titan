import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/completeMember.dart';
import 'package:myecl/phonebook/providers/association_picture_provider.dart';
import 'package:myecl/phonebook/providers/member_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';

class MemberCards extends HookConsumerWidget {
  const MemberCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    final completeMemberNotifier = ref.watch(completeMemberProvider.notifier);
    final associationPicture = ref.watch(associationPictureProvider);

    return ListView.builder(
                          padding: const EdgeInsets.all(1),
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                child: ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                          "Nom $index Prénom $index (Surnom $index)")),
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
                                  
                                    child:
                                    associationPicture.when(data: (picture){
                                      return CircleAvatar(
                                      radius: 80,
                                      backgroundImage: picture.isEmpty ?
                                      const AssetImage('assets/images/profile.png') :
                                      Image.memory(picture).image,
                                    );
                                    }, loading: () {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }, error: (e, s) {
                                    return const Center(
                                      child: Text(PhonebookTextConstants.errorLoadAssociationPicture),
                                    );
                                  }, 
                                  ),
                                  )
                                ],
                              ),
                              subtitle: Text("Email: $index"),
                              onTap: () {
                                completeMemberNotifier
                                    .setCompleteMember(CompleteMember.empty());
                                pageNotifier.setPhonebookPage(
                                    PhonebookPage.memberDetail);
                              },
                            ));
                          });
  }
}