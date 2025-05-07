import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/paiement/class/wallet_device.dart';
import 'package:myecl/paiement/tools/functions.dart';

class DeviceItem extends ConsumerWidget {
  final WalletDevice device;
  final bool isActual;
  final Future Function() onRevoke;
  const DeviceItem({
    super.key,
    required this.device,
    required this.isActual,
    required this.onRevoke,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            color: Colors.grey.shade200.withValues(alpha: 0.5),
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
                    if (device.status != WalletDeviceStatus.revoked) ...[
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: onRevoke,
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
                  const Text(
                    '(actuel)',
                    style: TextStyle(
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
