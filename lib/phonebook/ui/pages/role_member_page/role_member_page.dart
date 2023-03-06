import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/post.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/providers/post_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';


class RoleMemberPage extends HookConsumerWidget {
  const RoleMemberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(postProvider);
    final postNotifier = ref.watch(postProvider.notifier);
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    Post newPost = post;
    final associationList = useState([["Association 1","1"], ["Association 2","2"], ["Association 3","3"]]);
    final roleList = useState([["Rôle 1","1"], ["Rôle 2","2"], ["Rôle 3","3"]]);
    return Column(
      children: [
        const Text(PhonebookTextConstants.postAssociation),
        const SizedBox(width: 10),
        SizedBox(
          width: 200,
          child: Autocomplete<String>(
            initialValue: TextEditingValue(text: post.association.name),
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
              newPost = newPost.setAssociation(selection,id);
            },)),
        
        const SizedBox(width: 30),
        const Text(PhonebookTextConstants.postRole),
        const SizedBox(width: 10),
        SizedBox(
          width: 200,
          child: Autocomplete<String>(
            initialValue: TextEditingValue(text: post.role.name),
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
              newPost = newPost.setRole(selection,id);
            },)),
        ElevatedButton(
          onPressed: () {
            if (newPost.association.name == "") {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(PhonebookTextConstants.postAssociationError)));
              return;
            }
            else if (newPost.role.name == "") {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(PhonebookTextConstants.postRoleError)));
              return;
            }
            else {
            postNotifier.setPost(newPost);
            pageNotifier.setPhonebookPage(PhonebookPage.memberDetail);
            }
          },
         child: const Text(PhonebookTextConstants.validation),
         )
      ],
    );
  }
}