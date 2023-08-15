import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/ui/elocaps.dart';
import 'package:myecl/user/providers/user_provider.dart';

class HistoryPage extends HookConsumerWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    
    return ElocapsTemplate(child: Column(
      children: [
        const SizedBox(height: 20),
        Text("Bonjour bienvenue dans ton historique de parti ${user.nickname}"),
      ],
    ));
  }
}
