import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/order_index_provider.dart';
import 'package:myecl/amap/providers/user_amount_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';

class AddButton extends ConsumerWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexCmdNotifier = ref.watch(orderIndexProvider.notifier);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final solde = ref.watch(userAmountProvider);
    return GestureDetector(
      child: Container(
          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          height: 105,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                height: 100.0,
                decoration: BoxDecoration(
                  color: ColorConstants.background2.withOpacity(0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400.withOpacity(0.25),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(2, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 10,
                        ),
                        const Text("Ajouter",
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w900,
                                color: ColorConstants.textLight)),
                        Text(
                            solde.when(
                                data: (s) =>
                                    "Solde (" + s.toStringAsFixed(2) + "€)",
                                error: (e, s) => "0€",
                                loading: () => "0€"),
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.textDark)),
                        Container(
                          height: 5,
                        ),
                      ],
                    ),
                    const FaIcon(
                      FontAwesomeIcons.cartShopping,
                      size: 40,
                      color: ColorConstants.textLight,
                    )
                  ],
                ),
              ),
            ),
          )),
      onTap: () {
        pageNotifier.setAmapPage(6);
        indexCmdNotifier.setIndex(-1);
        clearCmd(ref);
      },
    );
  }
}
