import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/providers/membership_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';


class RoleMemberPage extends HookConsumerWidget {
  const RoleMemberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membership = ref.watch(membershipProvider);
    final membershipNotifier = ref.watch(membershipProvider.notifier);
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    Membership newMembership = membership;
    final associationList = useState([["Association 1","1"], ["Association 2","2"], ["Association 3","3"]]);
    final roleList = useState([["Rôle 1","1"], ["Rôle 2","2"], ["Rôle 3","3"]]);
    return Column(
      children: [
        const Text(PhonebookTextConstants.membershipAssociation),
        const SizedBox(width: 10),
        SizedBox(
          width: 200,
          child: Autocomplete<String>(
            initialValue: TextEditingValue(text: membership.association.name),
            optionsBuilder: (TextEditingValue textValue) {
              if (textValue.text == "") {
                return associationList.value.map((e) => e[0]).toList();
              }
              return associationList.value.map((e) => e[0]).toList().where((String option) {
                return option.toLowerCase().contains(textValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              String id = associationList.value.firstWhere((element) => element[0] == selection)[1];
              newMembership = newMembership.setAssociation(selection,id);
            },)),
        
        const SizedBox(width: 30),
        const Text(PhonebookTextConstants.membershipRole),
        const SizedBox(width: 10),
        SizedBox(
          width: 200,
          child: Autocomplete<String>(
            initialValue: TextEditingValue(text: membership.role.name),
            optionsBuilder: (TextEditingValue textValue) {
              if (textValue.text == "") {
                return roleList.value.map((e) => e[0]).toList();
              }
              return roleList.value.map((e) => e[0]).toList().where((String option) {
                return option.toLowerCase().contains(textValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              String id = roleList.value.firstWhere((element) => element[0] == selection)[1];
              newMembership = newMembership.setRole(selection,id);
            },)),
        ElevatedButton(
          onPressed: () {
            if (newMembership.association.name == "") {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(PhonebookTextConstants.membershipAssociationError)));
              return;
            }
            else if (newMembership.role.name == "") {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(PhonebookTextConstants.membershipRoleError)));
              return;
            }
            else {
            membershipNotifier.setMembership(newMembership);
            pageNotifier.setPhonebookPage(PhonebookPage.memberDetail);
            }
          },
         child: const Text(PhonebookTextConstants.validation),
         )
      ],
    );
  }
}