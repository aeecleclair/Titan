import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
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

    final localizeWithContext = AppLocalizations.of(context)!;

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
                localizeWithContext.settingsTooRecentVersion,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Spacer(flex: 3),
            Text(
              "${localizeWithContext.settingsVersion} $titanVersion, flavor ${getAppFlavor()}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "${localizeWithContext.settingsMinimalHyperionVersion} : $minimalHyperionVersion",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "${localizeWithContext.settingsHyperionVersion} (${Repository.host}) : ${versionVerifier.whenOrNull(data: (value) {
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
