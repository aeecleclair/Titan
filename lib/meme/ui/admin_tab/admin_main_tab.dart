import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/meme/ui/admin_tab/hidden_meme_list.dart';
import 'package:myecl/meme/ui/admin_tab/user_tab.dart';

class AdminTab extends ConsumerWidget {
  const AdminTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0, // Supprime l’espace du titre
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.people, size: 30)),
              Tab(icon: Icon(Icons.image_outlined, size: 30)),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            UserAdminTab(),
            HiddenMemeList(),
          ],
        ),
      ),
    );
  }
}
