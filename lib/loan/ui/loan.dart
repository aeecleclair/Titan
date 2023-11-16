import 'package:flutter/material.dart';
import 'package:myecl/loan/router.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';

class LoanTemplate extends StatelessWidget {
  final Widget child;
  const LoanTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const TopBar(
            title: LoanTextConstants.loan,
            root: LoanRouter.root,
          ),
          Expanded(child: child)
        ],
      ),
    );
  }
}
