import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/commande.dart';
import 'package:myecl/amap/providers/list_commande_provider.dart';
import 'package:myecl/amap/ui/pages/cmd_page/add_button.dart';
import 'package:myecl/amap/ui/pages/cmd_page/commade_ui.dart';

class ListeCommandes extends HookConsumerWidget {
  const ListeCommandes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cmds = ref.watch(listCommandeProvider);

    List<Widget> listWidgetCommande = [];

    if (cmds.isNotEmpty) {
      for (Commande c in cmds) {
        listWidgetCommande.add(CommandeUi(c: c));
      }
    } else {
      listWidgetCommande.add(Column(
        children: [
          Container(
            height: 70,
            alignment: Alignment.center,
            child: Text(
              "Pas de commande actuellement",
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ));
    }

    listWidgetCommande.add(const AddButton());
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(children: listWidgetCommande),
    );
  }
}
