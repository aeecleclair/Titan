import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';



class AdminModulePage extends HookConsumerWidget {
  const AdminModulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);


    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Text("oui")));
  }
}
