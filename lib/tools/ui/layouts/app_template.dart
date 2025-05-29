import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/drawer/ui/drawer_template.dart';
import 'package:myecl/version/providers/titan_version_provider.dart';
import 'package:myecl/version/providers/version_verifier_provider.dart';

class AppTemplate extends HookConsumerWidget {
  final Widget child;
  const AppTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versionVerifier = ref.watch(versionVerifierProvider);
    final titanVersion = ref.watch(titanVersionProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final check = versionVerifier.whenData(
      (value) => value.minimalTitanVersion <= titanVersion,
    );

    return check.maybeWhen(
      data: (value) {
        if (!value) {
          return child;
        }
        if (!isLoggedIn) {
          return child;
        }
        return DrawerTemplate(child: child);
      },
      orElse: () => child,
    );
  }
}
