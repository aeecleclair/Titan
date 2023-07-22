import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/router.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/top_bar.dart';
import 'package:myecl/user/providers/user_provider.dart';

class AdminTemplate extends HookConsumerWidget {
  final Widget child;
  const AdminTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meNotifier = ref.watch(asyncUserProvider.notifier);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TopBar(
                  title: AdminTextConstants.administration,
                  root: AdminRouter.root,
                  onMenu: () {
                    tokenExpireWrapper(ref, () async {
                      await meNotifier.loadMe();
                    });
                  }),
              Expanded(child: child)
            ],
          ),
        ),
      ),
    );
  }
}
