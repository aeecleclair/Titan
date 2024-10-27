import 'package:flutter/material.dart';
import 'package:myecl/paiement/router.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:myecl/paiement/tools/constants.dart';

class PaymentTemplate extends StatelessWidget {
  final Widget child;
  const PaymentTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const TopBar(
            title: PaiementTextConstants.paiement,
            root: PaymentRouter.root,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
