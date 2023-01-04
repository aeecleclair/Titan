import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/order_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/command_ui.dart';

class OrderSection extends HookConsumerWidget {
  final VoidCallback onTap, addOrder, onEdit;
  const OrderSection(
      {super.key,
      required this.onTap,
      required this.addOrder,
      required this.onEdit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderListProvider);
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Commandes',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AMAPColorConstants.textDark),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 195,
          child: orders.when(
            data: (data) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: addOrder,
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15.0),
                          padding: const EdgeInsets.all(12.0),
                          width: 100,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const RadialGradient(
                              colors: [
                                Color.fromARGB(223, 182, 212, 10),
                                AMAPColorConstants.greenGradient1,
                              ],
                              center: Alignment.topLeft,
                              radius: 1.3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AMAPColorConstants.greenGradient2
                                    .withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(3, 3),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: HeroIcon(
                              HeroIcons.plus,
                              color: Colors.white,
                              size: 50,
                            ),
                          )),
                    ),
                    ...data
                        .map((e) =>
                            CommandeUI(order: e, onTap: onTap, onEdit: onEdit))
                        .toList(),
                    const SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text(error.toString()),
          ),
        ),
      ],
    );
  }
}
