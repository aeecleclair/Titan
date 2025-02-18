import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/class/create_device.dart';
import 'package:myecl/paiement/class/wallet_device.dart';
import 'package:myecl/paiement/providers/device_list_provider.dart';
import 'package:myecl/paiement/providers/device_provider.dart';
import 'package:myecl/paiement/providers/key_service_provider.dart';
import 'package:myecl/paiement/tools/platform_info.dart';
import 'package:myecl/paiement/ui/pages/devices_page/add_device_button.dart';
import 'package:myecl/paiement/ui/pages/devices_page/device_item.dart';
import 'package:myecl/paiement/ui/paiement.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    final pageController = usePageController();

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return PaymentTemplate(
      child: FutureBuilder(
        future: deviceKey,
        builder: (context, snapshot) {
          return AsyncChild(
            value: devices,
            builder: (context, devices) {
              final shouldDisplayAddDevice = (snapshot.data == null ||
                      !devices.map((e) => e.id).contains(snapshot.data) ||
                      devices
                              .where((e) => e.id == snapshot.data)
                              .first
                              .status ==
                          WalletDeviceStatus.disabled) &&
                  displayAddDevice.value;
              return Column(
                children: [
                  Expanded(
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: pageController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        if (shouldDisplayAddDevice) ...[
                          AddDeviceButton(
                            onTap: () async {
                              final name = await getPlatformInfo();
                              final keyPair =
                                  await keyService.generateKeyPair();
                              final publicKey =
                                  (await keyPair.extractPublicKey()).bytes;
                              final base64PublicKey = base64Encode(publicKey);
                              final body = CreateDevice(
                                  name: name,
                                  ed25519PublicKey: base64PublicKey,);
                              final value =
                                  await deviceNotifier.registerDevice(body);
                              if (value != null) {
                                await keyService.saveKeyPair(keyPair);
                                await keyService.saveKeyId(value);
                                await devicesNotifier.getDeviceList();
                                displayAddDevice.value = false;
                              }
                            },
                          ),
                        ],
                        ...devices.map((device) {
                          return DeviceItem(
                              device: device,
                              isActual: device.id == snapshot.data,
                              onRevoke: () async {
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
                                                  WalletDeviceStatus.disabled,
                                            ),
                                          );
                                          if (value) {
                                            displayToastWithContext(
                                              TypeMsg.msg,
                                              "Appareil révoqué",
                                            );
                                            final savedId =
                                                await keyService.getKeyId();
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
                              },);
                        }),
                      ],
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: devices.length + (shouldDisplayAddDevice ? 1 : 0),
                    effect: WormEffect(
                      dotColor: Colors.grey.shade300,
                      activeDotColor: const Color.fromARGB(255, 4, 84, 84),
                      dotWidth: 7,
                      dotHeight: 7,
                    ),
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.decelerate,
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
