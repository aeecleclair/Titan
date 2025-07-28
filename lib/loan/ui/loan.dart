import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/loan/providers/item_list_provider.dart';
import 'package:titan/loan/providers/loaner_provider.dart';
import 'package:titan/loan/providers/loaners_items_provider.dart';
import 'package:titan/loan/router.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class LoanTemplate extends HookConsumerWidget {
  final Widget child;
  const LoanTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: ColorConstants.background,
      child: SafeArea(
        child: Column(
          children: [
            TopBar(
              root: LoanRouter.root,
              onBack: () {
                if (QR.currentPath ==
                    LoanRouter.root +
                        LoanRouter.admin +
                        LoanRouter.addEditLoan) {
                  final loanersItemsNotifier = ref.watch(
                    loanersItemsProvider.notifier,
                  );
                  final loaner = ref.watch(loanerProvider);
                  final itemList = ref.watch(itemListProvider);
                  loanersItemsNotifier.setTData(loaner, itemList);
                }
              },
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
