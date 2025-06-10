import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/others/tools/constants.dart';
import 'package:titan/version/providers/titan_version_provider.dart';

class UpdatePage extends HookConsumerWidget {
  const UpdatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titanVersion = ref.watch(titanVersionProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Spacer(flex: 2),
            const HeroIcon(HeroIcons.bellAlert, size: 100),
            const SizedBox(height: 50),
            const Center(
              child: Text(
                OthersTextConstants.tooOldVersion,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Spacer(flex: 3),
            Text(
              "${OthersTextConstants.version} $titanVersion",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
