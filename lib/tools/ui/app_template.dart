import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/drawer/providers/animation_provider.dart';
import 'package:myecl/drawer/ui/drawer_template.dart';
import 'package:myecl/version/providers/titan_version_provider.dart';
import 'package:myecl/version/providers/version_verifier_provider.dart';


class AppTemplate extends HookConsumerWidget {
  final Widget child;
  const AppTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versionVerifier = ref.watch(versionVerifierProvider);
    final titanVersion = ref.watch(titanVersionProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final check = versionVerifier
        .whenData((value) => value.minimalTitanVersion <= titanVersion);
    final animationController = useAnimationController(
        duration: const Duration(milliseconds: 500), initialValue: 0.0);
    final animationNotifier = ref.read(animationProvider.notifier);

    Future(() {
      animationNotifier.setController(animationController);
    });

    return check.when(
        data: (value) {
          if (value) {
            if (isLoggedIn) {
              return DrawerTemplate(child: child);
            } else {
              return child;
            }
          } else {
            return child;
          }
        },
        loading: () => child,
        error: (error, stack) => child);
  }
}
