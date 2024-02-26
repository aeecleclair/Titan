import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/is_admin.dart';
import 'package:myecl/phonebook/class/post.dart';
import 'package:myecl/phonebook/providers/complete_member_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/providers/post_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';

class MemberDetailPage extends HookConsumerWidget {
  const MemberDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isAdminProvider);
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    final memberProvider = ref.watch(completeMemberProvider);
    final postProviderNotifier = ref.watch(postProvider.notifier);
    return Container(
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color.fromARGB(255, 187, 187, 187)),
        child: Column(children: [
          const Text(PhonebookTextConstants.detail),
          Text("${PhonebookTextConstants.name} ${memberProvider.member.name}"),
          Text(
              "${PhonebookTextConstants.firstname} ${memberProvider.member.firstname}"),
          if (memberProvider.member.nickname != null)
            Text(
                "${PhonebookTextConstants.nickname} ${memberProvider.member.nickname!}"),
          Text(
              "${PhonebookTextConstants.email} ${memberProvider.member.email}"),
          const Text(PhonebookTextConstants
              .association), //à changer pour dépendre du nombre d'associatione
          Column(children: [
            for (var post in memberProvider.post)
              Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(),
                      color: const Color.fromARGB(255, 187, 187, 187)),
                  child:  Row(
                      children: [
                        const Spacer(flex: 1),
                        Text("${post.association.name} : ${post.role.name}",
                            style: const TextStyle(fontSize: 20)),
                        if (isAdmin)
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                postProviderNotifier.setPost(post);
                                pageNotifier.setPhonebookPage(
                                    PhonebookPage.addEditRoleMember);
                              }),
                        const Spacer(flex: 1),
                  ]))
          ]),
          if (isAdmin)
            ElevatedButton(
                onPressed: () {
                  postProviderNotifier.setPost(Post.empty());
                  pageNotifier
                      .setPhonebookPage(PhonebookPage.addEditRoleMember);
                },
                child: Row(
                  children: const [
                    Icon(Icons.add),
                    Text(PhonebookTextConstants.addRole)
                  ],
                ))
        ]));
  }
}
