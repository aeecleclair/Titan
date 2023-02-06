import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/version/providers/titan_version_provider.dart';
import 'package:myecl/version/providers/version_verifier_provider.dart';

class LandingPage extends HookConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versionVerifier = ref.watch(versionVerifierProvider);
    final titanVersion = ref.watch(titanVersionProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final check = versionVerifier.whenData((value) {
      return value.minimalTitanVersion <= titanVersion;
    });

    check.when(
      data: (value) => value
          ? isLoggedIn
              ? Navigator.pushReplacementNamed(context, '/appDrawer')
              : Navigator.pushReplacementNamed(context, '/login')
          : Navigator.pushReplacementNamed(context, '/update'),
      loading: () {},
      error: (error, stack) =>
          Navigator.pushReplacementNamed(context, '/noInternetPage'),
    );

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
