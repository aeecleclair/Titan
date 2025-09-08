import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/login/router.dart';
import 'package:myecl/router.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/providers/path_forwarding_provider.dart';
import 'package:myecl/tools/ui/widgets/loader.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/version/providers/minimal_hyperion_version_provider.dart';
import 'package:myecl/version/providers/titan_version_provider.dart';
import 'package:myecl/version/providers/version_verifier_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versionVerifier = ref.watch(versionVerifierProvider);
    final titanVersion = ref.watch(titanVersionProvider);
    final minimalHyperionVersion = ref.watch(minimalHyperionVersionProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final check = versionVerifier.whenData(
      (value) => value.minimalTitanVersion <= titanVersion,
    );
    final pathForwarding = ref.read(pathForwardingProvider);
    final isHyperionVersionCompatible = versionVerifier.whenData(
      (value) => isVersionCompatible(
        value.version,
        minimalHyperionVersion,
      ),
    );
    check.when(
      data: (value) {
        if (!value) {
          QR.to(AppRouter.update);
        }
        isHyperionVersionCompatible.when(
          data: (value) {
            if (!value) {
              QR.to(AppRouter.rollback);
            }
            if (!isLoggedIn) {
              QR.to(LoginRouter.root);
            }
            final user = ref.watch(asyncUserProvider);
            user.when(
              data: (_) {
                QR.to(pathForwarding.path);
              },
              error: (error, _) {
                QR.to(LoginRouter.root);
              },
              loading: () {},
            );
          },
          error: (error, _) => QR.to(AppRouter.noInternet),
          loading: () {},
        );
      },
      error: (error, _) => QR.to(AppRouter.noInternet),
      loading: () {},
    );
    return const Scaffold(body: Loader());
  }
}
