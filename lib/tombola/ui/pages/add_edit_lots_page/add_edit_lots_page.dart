import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../button_perso.dart';

class AddEditLotsPage extends HookConsumerWidget {
  const AddEditLotsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
            key: key,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    
                    border: OutlineInputBorder(),
                    hintText: 'Nom du Lot',
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    },
                    child: PersoButton(text: "Ajouter")),
                Text("Il faut ensuite gérér les images ")
              ],
              
            )));
  }
}
