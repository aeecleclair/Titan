import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';

class NotFoundPage extends HookConsumerWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Spacer(flex: 2),
            const HeroIcon(HeroIcons.faceFrown, size: 100),
            const SizedBox(height: 50),
            const Center(
              child: Text(
                "Ce n'est sûrement pas la page que tu cherches...",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Spacer(flex: 3),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  QR.to('/home');
                },
                child: const Text('Retourne en lieu sûr'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
