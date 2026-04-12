import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/mypayment/router.dart';

class PaymentTemplate extends HookConsumerWidget {
  final Widget child;
  const PaymentTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: ColorConstants.background),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TopBar(root: PaymentRouter.root),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
