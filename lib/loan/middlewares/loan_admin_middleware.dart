import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/providers/is_loan_admin_provider.dart';
import 'package:myecl/loan/router.dart';
import 'package:myecl/tools/providers/path_forwarding_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoanAdminMiddleware extends QMiddleware {
  final ProviderRef ref;

  LoanAdminMiddleware(this.ref);

  @override
  Future<String?> redirectGuard(String path) async {
    final isAdmin = ref.watch(isLoanAdminProvider);
    if (isAdmin) {
      return null;
    } else {
      ref.read(pathForwardingProvider.notifier).forward(LoanRouter.root);
      return LoanRouter.root;
    }
  }
}
