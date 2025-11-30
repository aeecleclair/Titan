import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:titan/chooser/providers/fingers_provider.dart';
import 'package:titan/chooser/ui/finger_dot.dart';

import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:titan/chooser/router.dart';

class FingerChooserPage extends HookConsumerWidget {
  const FingerChooserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fingers = ref.watch(fingersProvider);
    final ctrl = ref.read(fingersProvider.notifier);
    final teamCount = ref.watch(numberOfTeamsProvider);

    final hasTeams = fingers.any((f) => f.teamIndex != null);

    // États pour les compteurs
    final autoSecondsLeft = useState<int?>(null);
    final resetSecondsLeft = useState<int?>(null);

    final autoTimerRef = useRef<Timer?>(null);
    final resetTimerRef = useRef<Timer?>(null);

    // Timer d'auto-assignation des équipes
    useEffect(() {
      autoTimerRef.value?.cancel();

      if (!hasTeams && fingers.isNotEmpty) {
        autoSecondsLeft.value = 5;

        autoTimerRef.value = Timer.periodic(const Duration(seconds: 1), (
          timer,
        ) {
          final current = autoSecondsLeft.value;
          if (current == null) {
            timer.cancel();
            return;
          }

          if (current <= 1) {
            timer.cancel();
            autoSecondsLeft.value = null;
            ctrl.assignTeams(teamCount);
          } else {
            autoSecondsLeft.value = current - 1;
          }
        });
      }

      return () {
        autoTimerRef.value?.cancel();
      };
    }, [fingers.length, hasTeams, teamCount]);

    useEffect(() {
      resetTimerRef.value?.cancel();

      if (hasTeams && fingers.isEmpty) {
        resetSecondsLeft.value = 5;

        resetTimerRef.value = Timer.periodic(const Duration(seconds: 1), (
          timer,
        ) {
          final current = resetSecondsLeft.value;
          if (current == null) {
            timer.cancel();
            return;
          }

          if (current <= 1) {
            timer.cancel();
            resetSecondsLeft.value = null;
            ctrl.reset();
          } else {
            resetSecondsLeft.value = current - 1;
          }
        });
      }

      return () {
        resetTimerRef.value?.cancel();
      };
    }, [hasTeams, fingers.isEmpty]);

    final textColor = hasTeams ? Colors.white : Colors.black;
    final secondaryTextColor = hasTeams ? Colors.white70 : Colors.grey[700];

    // Texte du compteur affiché
    String countdownText = '';
    if (!hasTeams && fingers.isNotEmpty && autoSecondsLeft.value != null) {
      countdownText = 'Équipes auto dans ${autoSecondsLeft.value} s';
    } else if (hasTeams && fingers.isEmpty && resetSecondsLeft.value != null) {
      countdownText = 'Reset auto dans ${resetSecondsLeft.value} s';
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 🔹 Barre du haut à la façon CentralisationTemplate
              const TopBar(title: "Finger Chooser", root: ChooserRouter.root),
              // 🔹 Le contenu interactif du chooser
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  color: hasTeams ? Colors.black : Colors.white,
                  child: Listener(
                    behavior: HitTestBehavior.opaque,
                    onPointerDown: (e) =>
                        ctrl.addFinger(e.pointer, e.localPosition),
                    onPointerMove: (e) =>
                        ctrl.updateFinger(e.pointer, e.localPosition),
                    onPointerUp: (e) => ctrl.removeFinger(e.pointer),
                    onPointerCancel: (e) => ctrl.removeFinger(e.pointer),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                fingers.isEmpty
                                    ? (hasTeams
                                          ? 'Tout le monde a retiré — reset en cours'
                                          : 'Posez vos doigts')
                                    : '${fingers.length} doigt(s) détecté(s)',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Nombre d\'équipes : $teamCount',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: secondaryTextColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (countdownText.isNotEmpty)
                                Text(
                                  countdownText,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: secondaryTextColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        ...fingers.map((f) => FingerDot(finger: f)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
