import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/ph/ui/button.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhTemplate(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              QR.to(PhRouter.root + PhRouter.admin + PhRouter.add_ph);
            },
            child: const MyButton(
              text: "Add Ph",
            ),
          ),
        ],
      ),
    );
  }
}
