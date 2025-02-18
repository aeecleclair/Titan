import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/class/create_device.dart';
import 'package:myecl/paiement/class/wallet_device.dart';
import 'package:myecl/paiement/providers/device_provider.dart';
import 'package:myecl/paiement/providers/key_service_provider.dart';
import 'package:myecl/paiement/router.dart';
import 'package:myecl/paiement/tools/platform_info.dart';
import 'package:myecl/paiement/ui/pages/main_page/account_button.dart';
import 'package:myecl/paiement/ui/pages/pay_page/pay_page.dart';
import 'package:myecl/tools/functions.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AccountCard extends HookConsumerWidget {
  const AccountCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyService = ref.read(keyServiceProvider);
    final deviceNotifier = ref.watch(deviceProvider.notifier);

    void displayToastWithContext(TypeMsg type, String message) {
      displayToast(context, type, message);
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 9, 103, 103),
            Color(0xff017f80),
            Color.fromARGB(255, 4, 84, 84),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Solde personnel',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          QR.to(PaymentRouter.root + PaymentRouter.stats);
                        },
                        child: const HeroIcon(
                          HeroIcons.chartPie,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "348,23 €",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AccountButton(
                  icon: HeroIcons.devicePhoneMobile,
                  title: "Appareils",
                  onPressed: () async {
                    QR.to(PaymentRouter.root + PaymentRouter.devices);
                  },
                ),
                // if (!kIsWeb)
                AccountButton(
                  icon: HeroIcons.qrCode,
                  title: "Payer",
                  onPressed: () async {
                    String? keyId = await keyService.getKeyId();
                    if (keyId == null) {
                      final name = await getPlatformInfo();
                      final keyPair = await keyService.generateKeyPair();
                      final publicKey =
                          (await keyPair.extractPublicKey()).bytes;
                      final base64PublicKey = base64Encode(publicKey);
                      final body = CreateDevice(
                        name: name,
                        ed25519PublicKey: base64PublicKey,
                      );
                      final value = await deviceNotifier.registerDevice(body);
                      if (value != null) {
                        await keyService.saveKeyPair(keyPair);
                        await keyService.saveKeyId(value);
                      }
                      keyId = value;
                    }
                    if (keyId == null) {
                      displayToastWithContext(
                          TypeMsg.error, "Erreur lors de la création de l'appareil");
                      return;
                    }
                    final device = await deviceNotifier.getDevice(keyId);
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      scrollControlDisabledMaxHeightRatio:
                          (1 - 80 / MediaQuery.of(context).size.height),
                      builder: (context) => const PayPage(),
                    );
                    device.when(
                      data: (device) {
                        if (device.status == WalletDeviceStatus.active) {
                        } else if (device.status ==
                            WalletDeviceStatus.unactive) {
                          displayToastWithContext(
                              TypeMsg.error, "Votre appareil n'est pas activé");
                        } else {
                          displayToastWithContext(
                              TypeMsg.error, "Votre appareil a été révoqué");
                        }
                      },
                      error: (e, s) {
                        displayToastWithContext(TypeMsg.error,
                            "Erreur lors de la récupération de l'appareil");
                      },
                      loading: () {},
                    );
                  },
                ),
                // if (!kIsWeb)
                AccountButton(
                  icon: HeroIcons.viewfinderCircle,
                  title: "Scanner",
                  onPressed: () async {
                    QR.to(PaymentRouter.root + PaymentRouter.scan);
                  },
                ),
                AccountButton(
                  icon: HeroIcons.creditCard,
                  title: "Alimenter",
                  onPressed: () async {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
