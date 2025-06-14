import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/router.dart';
import 'package:myecl/routing/providers/auth_redirect_service_provider.dart';
import 'package:myecl/tools/ui/widgets/loader.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final redirectPath = ref.watch(
      authRedirectServiceProvider.select(
        (service) => service.getRedirect(QR.currentPath),
      ),
    );

    if (redirectPath != null &&
        Uri.parse(redirectPath).path != AppRouter.loading) {
      Future.microtask(() {
        QR.to(redirectPath);
      });
    }

    return const Scaffold(body: Loader());
  }
}
