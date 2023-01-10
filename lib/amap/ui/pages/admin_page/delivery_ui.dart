import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class DeliveryUi extends HookConsumerWidget {
  final Delivery delivery;
  const DeliveryUi({super.key, required this.delivery});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryListNotifier = ref.watch(deliveryListProvider.notifier);
    void displayVoteWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        padding: const EdgeInsets.all(12.0),
        height: 160,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AMAPColorConstants.textDark.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                  '${AMAPTextConstants.the} ${processDate(delivery.deliveryDate)}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AMAPColorConstants.textDark)),
              const Spacer(),
              Text(
                "${delivery.products.length} ${AMAPTextConstants.product}${delivery.products.length != 1 ? "s" : ""}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AMAPColorConstants.textLight),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((context) => CustomDialogBox(
                              title: delivery.status == DeliveryStatus.creation
                              ? AMAPTextConstants.openDelivery
                                  // ? AMAPTextConstants.unlock
                                  : AMAPTextConstants.lock,
                              descriptions: delivery.status == DeliveryStatus.creation
                              ? AMAPTextConstants.openningDelivery
                                  // ? AMAPTextConstants.unlockingDelivery
                                  : AMAPTextConstants.lockingDelivery,
                              onYes: () {
                                tokenExpireWrapper(ref, () async {
                                  switch (delivery.status){
                                    case DeliveryStatus.creation:
                                      deliveryListNotifier.openDelivery(delivery);
                                      break;
                                    case DeliveryStatus.orderable:
                                    deliveryListNotifier.lockDelivery(delivery);
                                      break;
                                    case DeliveryStatus.locked:
                                    deliveryListNotifier.deliverDelivery(delivery);
                                      break;
                                    case DeliveryStatus.deliverd:
                                    deliveryListNotifier.archiveDelivery(delivery);
                                      break;}
                                  });
                              })));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      // margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          colors: !(delivery.status == DeliveryStatus.creation)
                              ? [
                                  AMAPColorConstants.redGradient1,
                                  AMAPColorConstants.redGradient2,
                                ]
                              : [
                                  AMAPColorConstants.greenGradient1,
                                  AMAPColorConstants.greenGradient2,
                                ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            AMAPTextConstants.openDelivery,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            !(delivery.status == DeliveryStatus.creation) ? Icons.lock : Icons.lock_open,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
