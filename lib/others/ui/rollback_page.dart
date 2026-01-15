import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/others/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/version/providers/minimal_hyperion_version_provider.dart';
import 'package:titan/version/providers/titan_version_provider.dart';
import 'package:titan/version/providers/version_verifier_provider.dart';

class RollbackPage extends HookConsumerWidget {
  const RollbackPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final minimalHyperionVersion = ref.watch(minimalHyperionVersionProvider);
    final versionVerifier = ref.watch(versionVerifierProvider);
    final titanVersion = ref.watch(titanVersionProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Spacer(flex: 2),
            const HeroIcon(HeroIcons.rocketLaunch, size: 100),
            const SizedBox(height: 50),
            Center(
              child: Text(
                getAppFlavor() == "dev"
                    ? OthersTextConstants.tooRecentVersionDevFlavor
                    : OthersTextConstants.tooRecentVersion,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Spacer(flex: 3),
            Text(
              "${OthersTextConstants.version} $titanVersion, flavor ${getAppFlavor()}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "${OthersTextConstants.minimalHyperionVersion} : $minimalHyperionVersion",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "${OthersTextConstants.hyperionVersion} (${Repository.host}) : ${versionVerifier.whenOrNull(data: (value) {
                return value.version;
              })}",
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
