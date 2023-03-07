import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class PriceCard extends HookConsumerWidget {
  const PriceCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
            key: key,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 5),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Prix (€)',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, right: 15),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nombres de tickets à ce prix',
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
