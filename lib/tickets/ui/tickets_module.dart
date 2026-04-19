import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tickets/providers/tickets_on_back_provider.dart';
import 'package:titan/tickets/router.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:titan/tools/constants.dart';

class TicketTemplate extends HookConsumerWidget {
  final Widget child;
  const TicketTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onBack = ref.watch(ticketsOnBackProvider);

    VoidCallback? topBarOnBack;
    if (onBack != null) {
      topBarOnBack = () {
        ref.read(ticketsOnBackProvider.notifier).state = null;
        onBack();
      };
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: ColorConstants.background),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TopBar(root: TicketsRouter.root, onBack: topBarOnBack),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
