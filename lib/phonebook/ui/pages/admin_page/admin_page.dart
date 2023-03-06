import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/association_bar.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/role_bar.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    return DefaultTabController(
      length: 2,
      child: Column(
        children: const [
          SizedBox(
            height: 10,
          ),
          TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: [
              Tab(
                text: PhonebookTextConstants.associationPure,
              ),
              Tab(
                text: PhonebookTextConstants.rolePure,
              )
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                AssociationBar(),
                RoleBar(),
              ],
            ),
          ),
        ],
      ),
      );
  }
}
