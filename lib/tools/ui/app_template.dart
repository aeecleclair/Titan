import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/drawer/ui/drawer_template.dart';
import 'package:myecl/version/providers/titan_version_provider.dart';
import 'package:myecl/version/providers/version_verifier_provider.dart';

class AppTemplate extends ConsumerWidget {
  final Widget child;
  const AppTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versionVerifier = ref.watch(versionVerifierProvider);
    final titanVersion = ref.watch(titanVersionProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final check = versionVerifier
        .whenData((value) => value.minimalTitanVersion <= titanVersion);
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
