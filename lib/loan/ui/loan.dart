import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/router.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoanTemplate extends HookConsumerWidget {
  final Widget child;
  const LoanTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        children: [
          TopBar(
            title: LoanTextConstants.loan,
            root: LoanRouter.root,
            onBack: () {
              if (QR.currentPath ==
                  LoanRouter.root +
                      LoanRouter.admin +
                      LoanRouter.addEditLoan) {}
            },
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
