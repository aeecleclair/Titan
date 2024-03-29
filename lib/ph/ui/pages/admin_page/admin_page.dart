import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/providers/ph_list_provider.dart';
import 'package:myecl/ph/ui/button.dart';
import 'package:myecl/ph/ui/pages/add_ph_page/add_page.dart';
import 'package:myecl/ph/ui/pages/ph.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final dateController = TextEditingController();
    final phListNotifier = ref.watch(phListProvider.notifier);
    return PhTemplate(
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: "Titre du journal",
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: dateController,
            decoration: const InputDecoration(
              hintText: "Date",
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 20),
          const PdfPicker(),
          const SizedBox(height: 40),
          GestureDetector(
              onTap: () async {
                await phListNotifier
                    .addPh(Ph(date: '01-01-2000', name: "SuperPh"));
              },
              child: const MyButton(
                text: "Ajouter",
              )),
          Text(titleController.text),
        ],
      ),
    );
  }
}
