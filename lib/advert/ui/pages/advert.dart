import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/router.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';

class AdvertTemplate extends HookConsumerWidget {
  final Widget child;
  const AdvertTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAdvertisersNotifier = ref.read(advertiserProvider.notifier);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              TopBar(
                title: AdvertTextConstants.advert,
                root: AdvertRouter.root,
                onBack: () {
                  selectedAdvertisersNotifier.clearAdvertiser();
                },
              ),
              const SizedBox(height: 30),
              Expanded(child: child)
            ],
          ),
        ),
      ),
    );
  }
}
