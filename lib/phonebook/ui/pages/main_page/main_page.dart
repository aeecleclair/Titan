import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/phonebook/class/completeMember.dart';
import 'package:myecl/phonebook/providers/member_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myecl/admin/providers/is_admin.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = useState("");
    final searchType = useState("name");
    final isAdmin = ref.watch(isAdminProvider);
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    final completeMemberNotifier = ref.watch(completeMemberProvider.notifier);
    return Expanded(
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                Column(children: [
                  const SizedBox(height: 60),
                  Row(
                    children: [
                      const Text(PhonebookTextConstants.phonebookSearch),
                      DropdownButton<String>(
                        value: searchType.value,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 14,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          searchType.value = newValue!;
                        },
                        items: <List<String>>[
                          [PhonebookTextConstants.phonebookSearchName, "name"],
                          [PhonebookTextConstants.phonebookSearchRole, "role"],
                          [
                            PhonebookTextConstants.phonebookSearchAssociation,
                            "association"
                          ]
                        ].map<DropdownMenuItem<String>>((List<String> value) {
                          return DropdownMenuItem<String>(
                            value: value[1],
                            child: Text(value[0]),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  Row(children: [
                    const Text(PhonebookTextConstants.phonebookSearchField),
                    const SizedBox(width: 5),
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (String value) {
                                search.value = value;
                              },
                            )))
                  ]),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 7),
                    color: Colors.black,
                    height: 2,
                  ),
                  Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(
                              PhonebookTextConstants.phonebookMargin),
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                child: ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                          "Nom $index Prénom $index (Surnom $index)")),
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
                          }))
                ]),
                if (isAdmin)
                  Positioned(
                    top: 15,
                    right: 15,
                    child: GestureDetector(
                      onTap: () {
                        pageNotifier.setPhonebookPage(PhonebookPage.admin);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5))
                            ]),
                        child: Row(
                          children: const [
                            HeroIcon(HeroIcons.userGroup, color: Colors.white),
                            SizedBox(width: 10),
                            Text("Admin",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            )));
  }
}
