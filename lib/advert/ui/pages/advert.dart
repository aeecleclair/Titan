import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/advert/providers/selected_association_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/advert/router.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class AdvertTemplate extends HookConsumerWidget {
  final Widget child;
  const AdvertTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAssociationsNotifier = ref.read(
      selectedAssociationProvider.notifier,
    );
    return Scaffold(
      body: Container(
        color: ColorConstants.background,
        child: SafeArea(
          child: Column(
            children: [
              TopBar(
                root: AdvertRouter.root,
                onBack: () {
                  selectedAssociationsNotifier.clearAssociation();
                },
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
