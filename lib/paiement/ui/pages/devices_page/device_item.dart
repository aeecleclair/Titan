import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/paiement/class/wallet_device.dart';
import 'package:myecl/paiement/providers/device_list_provider.dart';
import 'package:myecl/paiement/providers/key_service_provider.dart';
import 'package:myecl/paiement/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';

class DeviceItem extends ConsumerWidget {
  final WalletDevice device;
  final bool isActual;
  const DeviceItem({super.key, required this.device, required this.isActual});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devicesNotifier = ref.watch(deviceListProvider.notifier);
    final keyService = ref.watch(keyServiceProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            color: Colors.grey.shade200.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HeroIcon(
                  HeroIcons.devicePhoneMobile,
                  size: 180,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      device.name,
                      style: const TextStyle(
                        color: Color(0xff204550),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (device.status != WalletDeviceStatus.disabled) ...[
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialogBox(
                                title: "Révoquer l'appareil ?",
                                descriptions:
                                    "Vous ne pourrez plus utiliser cet appareil pour les paiements",
                                onYes: () async {
                                  tokenExpireWrapper(ref, () async {
                                    final value = await devicesNotifier
                                        .revokeDevice(device);
                                    if (value) {
                                      displayToastWithContext(
                                        TypeMsg.msg,
                                        "Appareil révoqué",
                                      );
                                      final savedId = await keyService.getKeyId();
                                      if (savedId == device.id) {
                                        await keyService.clear();
                                      }
                                    } else {
                                      displayToastWithContext(
                                        TypeMsg.error,
                                        "Erreur lors de la révocation de l'appareil",
                                      );
                                    }
                                  });
                                },
                              );
                            },
                          );
                        },
                        child: const HeroIcon(
                          HeroIcons.trash,
                          size: 25,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ],
                ),
                if (isActual)
                  Text(
                    '(actuel)',
                    style: const TextStyle(
                      color: Color(0xff204550),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                getStatusTag(device.status),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
