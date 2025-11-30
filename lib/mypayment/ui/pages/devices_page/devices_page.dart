import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/class/create_device.dart';
import 'package:titan/mypayment/class/wallet_device.dart';
import 'package:titan/mypayment/providers/device_list_provider.dart';
import 'package:titan/mypayment/providers/device_provider.dart';
import 'package:titan/mypayment/providers/has_accepted_tos_provider.dart';
import 'package:titan/mypayment/providers/key_service_provider.dart';
import 'package:titan/mypayment/tools/functions.dart';
import 'package:titan/mypayment/ui/pages/devices_page/add_device_button.dart';
import 'package:titan/mypayment/ui/pages/devices_page/device_item.dart';
import 'package:titan/mypayment/ui/pages/main_page/account_card/device_dialog_box.dart';
import 'package:titan/mypayment/ui/mypayment.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';

class DevicesPage extends HookConsumerWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(deviceListProvider);
    final devicesNotifier = ref.read(deviceListProvider.notifier);
    final deviceNotifier = ref.read(deviceProvider.notifier);
    final keyService = ref.watch(keyServiceProvider);
    final deviceKey = keyService.getKeyId();
    final displayAddDevice = useState(true);
    final hasAcceptedToS = ref.watch(hasAcceptedTosProvider);
    final showRovokedDevices = useState(false);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    Future<String> getDeviceName() async {
      final deviceInfo = DeviceInfoPlugin();
      if (Theme.of(context).platform == TargetPlatform.android) {
        return deviceInfo.androidInfo.then((info) => info.model);
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        return deviceInfo.iosInfo.then((info) => info.utsname.machine);
      } else {
        return Future.value("Unknown Device");
      }
    }

    return PaymentTemplate(
      child: Refresher(
        onRefresh: () async {
          await devicesNotifier.getDeviceList();
        },
        child: FutureBuilder(
          future: deviceKey,
          builder: (context, snapshot) {
            return AsyncChild(
              value: devices,
              builder: (context, devices) {
                final activeDevices = devices
                    .where(
                      (device) => device.status != WalletDeviceStatus.revoked,
                    )
                    .toList();

                final inactiveDevices = devices
                    .where(
                      (device) => device.status == WalletDeviceStatus.revoked,
                    )
                    .toList();

                activeDevices.sort((a, b) {
                  if (a.id == snapshot.data) return -1;
                  if (b.id == snapshot.data) return 1;
                  return statusOrder(a.status).compareTo(statusOrder(b.status));
                });

                inactiveDevices.sort((a, b) {
                  if (a.id == snapshot.data) return -1;
                  if (b.id == snapshot.data) return 1;
                  return statusOrder(a.status).compareTo(statusOrder(b.status));
                });

                final firstDevice = devices
                    .where((element) => element.id == snapshot.data)
                    .firstOrNull;

                final shouldDisplayAddDevice =
                    (snapshot.data == null ||
                        firstDevice == null ||
                        firstDevice.status == WalletDeviceStatus.revoked) &&
                    displayAddDevice.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (shouldDisplayAddDevice && !kIsWeb)
                      AddDeviceButton(
                        onTap: () async {
                          if (!hasAcceptedToS) {
                            displayToastWithContext(
                              TypeMsg.error,
                              "Veuillez accepter les Conditions Générales d'Utilisation.",
                            );
                            return;
                          }
                          final name = await getDeviceName();
                          final keyPair = await keyService.generateKeyPair();
                          final publicKey =
                              (await keyPair.extractPublicKey()).bytes;
                          final base64PublicKey = base64Encode(publicKey);
                          final body = CreateDevice(
                            name: name,
                            ed25519PublicKey: base64PublicKey,
                          );
                          final value = await deviceNotifier.registerDevice(
                            body,
                          );
                          if (value != null) {
                            await keyService.saveKeyPair(keyPair);
                            await keyService.saveKeyId(value);
                            await devicesNotifier.getDeviceList();
                            displayAddDevice.value = false;
                            if (context.mounted) {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return DeviceDialogBox(
                                    title:
                                        'Demande d\'activation de l\'appareil',
                                    descriptions:
                                        "La demande d'activation est prise en compte, veuillez consulter votre boite mail pour finaliser la démarche",
                                    buttonText: "Ok",
                                    onClick: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              );
                            }
                          }
                        },
                      ),
                    // Afficher les appareils actifs
                    ...activeDevices.map((device) {
                      return DeviceItem(
                        device: device,
                        isActual: device.id == snapshot.data,
                        onRevoke: () async {
                          if (!hasAcceptedToS) {
                            displayToastWithContext(
                              TypeMsg.error,
                              "Veuillez accepter les Conditions Générales d'Utilisation.",
                            );
                            return;
                          }
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
                                        .revokeDevice(
                                          device.copyWith(
                                            status: WalletDeviceStatus.revoked,
                                          ),
                                        );
                                    if (value) {
                                      displayToastWithContext(
                                        TypeMsg.msg,
                                        "Appareil révoqué",
                                      );
                                      final savedId = await keyService
                                          .getKeyId();
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
                      );
                    }),

                    if (inactiveDevices.isNotEmpty) ...[
                      GestureDetector(
                        onTap: () {
                          showRovokedDevices.value = !showRovokedDevices.value;
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 10,
                            top: 20,
                            left: 30,
                            right: 30,
                          ),
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: const [
                                Color.fromARGB(255, 9, 103, 103),
                                Color(0xff017f80),
                                Color.fromARGB(255, 4, 84, 84),
                              ],
                              center: Alignment.topLeft,
                              radius: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff017f80).withValues(alpha: 0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(
                                  0,
                                  1,
                                ), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              showRovokedDevices.value
                                  ? 'Masquer les appareils revoqués'
                                  : 'Afficher les appareils revoqués',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (showRovokedDevices.value) ...[
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Appareils révoqués',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        ...inactiveDevices.map((device) {
                          return DeviceItem(
                            device: device,
                            isActual: device.id == snapshot.data,
                            onRevoke: () async {
                              if (!hasAcceptedToS) {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  "Veuillez accepter les Conditions Générales d'Utilisation.",
                                );
                                return;
                              }
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
                                            .revokeDevice(
                                              device.copyWith(
                                                status:
                                                    WalletDeviceStatus.revoked,
                                              ),
                                            );
                                        if (value) {
                                          displayToastWithContext(
                                            TypeMsg.msg,
                                            "Appareil révoqué",
                                          );
                                          final savedId = await keyService
                                              .getKeyId();
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
                          );
                        }),
                      ],
                    ],
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
