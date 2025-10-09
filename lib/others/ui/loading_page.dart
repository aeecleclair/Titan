import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/login/router.dart';
import 'package:titan/router.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/tools/ui/widgets/loader.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:titan/version/providers/titan_version_provider.dart';
import 'package:titan/version/providers/version_verifier_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versionVerifier = ref.watch(versionVerifierProvider);
    final titanVersion = ref.watch(titanVersionProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final check = versionVerifier.whenData(
      (value) => value.minimalTitanVersion <= titanVersion,
    );
    final pathForwarding = ref.read(pathForwardingProvider);
    check.when(
      data: (value) {
        if (!value) {
          QR.to(AppRouter.update);
        }
        if (!isLoggedIn) {
          QR.to(LoginRouter.root);
        }
        final user = ref.watch(asyncUserProvider);
        user.when(
          data: (data) {
            QR.to(pathForwarding.path);
          },
          error: (error, s) {
            QR.to(LoginRouter.root);
          },
          loading: () {},
        );
      },
      loading: () {},
      error: (error, stack) => QR.to(AppRouter.noInternet),
    );
    return const Scaffold(body: Loader());
  }
}
