import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:titan/chooser/providers/fingers_provider.dart';
import 'package:titan/chooser/ui/finger_dot.dart';

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

    // 🔥 Timer d'auto-assignation des équipes
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

    // 🔥 Timer de reset auto après que tout le monde ait retiré ses doigts
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

    // Clé pour pouvoir ouvrir le drawer depuis le leading
    final scaffoldKey = useMemoized(() => GlobalKey<ScaffoldState>());

    return Scaffold(
      key: scaffoldKey,
      // Drawer local simple — à adapter si tu veux coller celui de Titan
      drawer: Drawer(
        child: Column(
          children: const [
            DrawerHeader(
              child: Text("Menu Titan Chooser", style: TextStyle(fontSize: 20)),
            ),
            ListTile(title: Text("Accueil")),
            ListTile(title: Text("Autre module")),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: hasTeams ? Colors.black : null,
        foregroundColor: hasTeams ? Colors.white : null,
        // 🔥 Icône menu en haut à gauche
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text('Finger Chooser'),
        actions: [
          // ⚙ Bouton réglages en haut à droite
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              final current = ref.read(numberOfTeamsProvider);
              final controller = TextEditingController(
                text: current.toString(),
              );

              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Réglages'),
                    content: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Nombre d\'équipes',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Annuler'),
                      ),
                      TextButton(
                        onPressed: () {
                          final value =
                              int.tryParse(controller.text.trim()) ?? 2;
                          final safeValue = value < 1 ? 1 : value;
                          ref.read(numberOfTeamsProvider.notifier).state =
                              safeValue;
                          Navigator.of(context).pop();
                        },
                        child: const Text('Valider'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        color: hasTeams ? Colors.black : Colors.white,
        child: Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: (e) => ctrl.addFinger(e.pointer, e.localPosition),
          onPointerMove: (e) => ctrl.updateFinger(e.pointer, e.localPosition),
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
                      style: TextStyle(fontSize: 20, color: textColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Nombre d\'équipes : $teamCount',
                      style: TextStyle(fontSize: 14, color: secondaryTextColor),
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
    );
  }
}
