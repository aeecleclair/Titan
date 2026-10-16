import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/mypayment/class/wallet_device.dart';
import 'package:titan/mypayment/tools/constants.dart';
import 'package:titan/mypayment/tools/functions.dart';
import 'package:titan/tools/providers/theme_provider.dart';

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
    final isDarkTheme = ref.watch(themeProvider);
    final secondaryGreen = MyPaymentColors(isDarkTheme).secondaryGreen;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
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
              color: Theme.of(
                context,
              ).colorScheme.secondaryFixed.withValues(alpha: 0.5),
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
                          style: TextStyle(
                            color: secondaryGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isActual)
                          Text(
                            '(cet appareil)',
                            style: TextStyle(
                              color: secondaryGreen,
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
                        child: HeroIcon(
                          HeroIcons.trash,
                          size: 25,
                          color: secondaryGreen,
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
