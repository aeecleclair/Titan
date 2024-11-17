import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/sg/class/sg.dart';
import 'package:myecl/sg/class/sg_state.dart';
import 'package:myecl/sg/providers/refresher_provider.dart';
import 'package:myecl/sg/router.dart';
import 'package:myecl/sg/tools/functions.dart';
import 'package:myecl/sg/tools/timeManager.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SgCard extends ConsumerWidget {
  final Sg sg;
  const SgCard({
    super.key,
    required this.sg,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = getStateByDate(sg.openDate, sg.closeDate);
    final refr = ref.watch(refreshProvider);
    final refreshNotifier = ref.watch(refreshProvider.notifier);
    return GestureDetector(
      onTap: () {
        if (state == SgState.open) {
          QR.to(ShotgunRouter.root + ShotgunRouter.admin);
        }
      },
      child: CardLayout(
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: const Image(
                image: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                ),
                width: 100,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                Text(
                  sg.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                state == SgState.open
                    ? const Text("En cours")
                    : TimeDifferenceWidget(
                        startDate: sg.openDate,
                        endDate: sg.closeDate,
                        b: beforeOrAfter(sg),
                        onTimeElapsed: () {
                          refreshNotifier.setState();
                        },
                      ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                sgStateToString(state),
                style: TextStyle(
                  color: sgStateToColor(state),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
