import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/paiement/class/wallet_device.dart';
import 'package:titan/paiement/tools/functions.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.grey.shade200.withValues(alpha: 0.5),
              child: SizedBox(
                height: isActual ? 80 : 70,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          device.name,
                          style: const TextStyle(
                            color: Color(0xff204550),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isActual)
                          const Text(
                            '(cet appareil)',
                            style: TextStyle(
                              color: Color(0xff204550),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Spacer(),
                    getStatusTag(device.status),
                    if (device.status != WalletDeviceStatus.revoked) ...[
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: onRevoke,
                        child: const HeroIcon(
                          HeroIcons.trash,
                          size: 25,
                          color: Color(0xff204550),
                        ),
                      ),
                    ],
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
