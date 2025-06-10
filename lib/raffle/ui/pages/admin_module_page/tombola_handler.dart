import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/group_list_provider.dart';
import 'package:titan/raffle/providers/raffle_list_provider.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/raffle/ui/pages/admin_module_page/confirm_creation.dart';
import 'package:titan/raffle/ui/pages/admin_module_page/tombola_card.dart';

class TombolaHandler extends HookConsumerWidget {
  const TombolaHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupList = ref.watch(allGroupListProvider);
    final raffleList = ref.watch(raffleListProvider);
    final groupChoosen = useState(SimpleGroup.empty());

    void displayWinningsDialog(List<SimpleGroup> groups, Function callback) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 100 + groups.length * 35.0,
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const Text(
                    "Pour quel groupe ?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: RaffleColorConstants.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: groups.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          groupChoosen.value = groups[index];
                          Navigator.pop(context);
                          callback();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Text(
                              groups[index].name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: RaffleColorConstants.textDark,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text(
            RaffleTextConstants.raffle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: RaffleColorConstants.textDark,
            ),
          ),
        ),
        SizedBox(
          height: 135,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                const SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(
                        colors: [
                          RaffleColorConstants.gradient1,
                          RaffleColorConstants.gradient2,
                        ],
                        center: Alignment.topLeft,
                        radius: 1.8,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: RaffleColorConstants.textDark.withValues(
                            alpha: 0.2,
                          ),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: GestureDetector(
                        onTap: () {
                          groupList.when(
                            data: (data) {
                              displayWinningsDialog(data, () {
                                if (groupChoosen.value.id !=
                                    SimpleGroup.empty().id) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ConfirmCreationDialog(
                                        group: groupChoosen.value,
                                      );
                                    },
                                  );
                                }
                              });
                            },
                            error: (e, s) => Text('Error: $e'),
                            loading: () => const CircularProgressIndicator(),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: const HeroIcon(
                            HeroIcons.plus,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ...raffleList.when(
                  data: (raffles) {
                    return raffles
                        .map((raffle) => TombolaCard(raffle: raffle))
                        .toList();
                  },
                  error: (e, s) => [Text("Error: $e")],
                  loading: () => const [CircularProgressIndicator()],
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
