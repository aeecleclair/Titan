// From https://github.com/juliansteenbakker/mobile_scanner/blob/master/example/lib/barcode_scanner_controller.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:titan/paiement/providers/barcode_provider.dart';
import 'package:titan/paiement/providers/bypass_provider.dart';
import 'package:titan/paiement/providers/last_time_scanned.dart';
import 'package:titan/paiement/providers/ongoing_transaction.dart';
import 'package:titan/paiement/providers/scan_provider.dart';
import 'package:titan/paiement/providers/selected_store_provider.dart';
import 'package:titan/paiement/ui/pages/scan_page/scan_overlay_shape.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Scanner extends StatefulHookConsumerWidget {
  const Scanner({super.key});

  @override
  ConsumerState<Scanner> createState() => ScannerState();
}

class ScannerState extends ConsumerState<Scanner> with WidgetsBindingObserver {
  final controller = MobileScannerController(autoStart: false);
  String? scannedValue;

  StreamSubscription<Object?>? _subscription;

  void resetScanner() {
    setState(() {
      scannedValue = null;
    });
    controller.start();
  }

  void showWithoutMembershipDialog(Function() onYes) async {
    await showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          title: "Pas d'adhésion",
          descriptions:
              "Ce produit n'est pas disponnible pour les non-adhérents. Confirmer l'encaissement ?",
          onYes: () async {
            tokenExpireWrapper(ref, () async {
              onYes.call();
            });
          },
        );
      },
    );
  }

  void displayToastWithContext(TypeMsg type, String msg) {
    displayToast(context, type, msg);
  }

  void _handleBarcode(BarcodeCapture barcodes) async {
    final lastTimeScanned = ref.watch(lastTimeScannedProvider);
    final lastTimeScannedNotifier = ref.read(lastTimeScannedProvider.notifier);
    if (lastTimeScanned != null &&
        DateTime.now().difference(lastTimeScanned) <
            const Duration(seconds: 5)) {
      return;
    }
    lastTimeScannedNotifier.updateLastTimeScanned(DateTime.now());
    final bypass = ref.watch(bypassProvider);
    final barcode = ref.watch(barcodeProvider);
    final barcodeNotifier = ref.read(barcodeProvider.notifier);
    final store = ref.read(selectedStoreProvider);
    final scanNotifier = ref.read(scanProvider.notifier);
    final ongoingTransactionNotifier = ref.read(
      ongoingTransactionProvider.notifier,
    );
    if (mounted && barcodes.barcodes.isNotEmpty && barcode == null) {
      final data = barcodeNotifier.updateBarcode(
        barcodes.barcodes.firstOrNull!.rawValue!,
      );
      if (!bypass) {
        final canScan = await scanNotifier.canScan(store.id, data);
        if (!canScan) {
          showWithoutMembershipDialog(() async {
            final value = await scanNotifier.scan(store.id, data, bypass: true);
            if (value == null) {
              displayToastWithContext(TypeMsg.error, "QR Code déjà utilisé");
              barcodeNotifier.clearBarcode();
              ongoingTransactionNotifier.clearOngoingTransaction();
              return;
            }
            ongoingTransactionNotifier.updateOngoingTransaction(value);
          });
          return;
        }
      }
      final value = await scanNotifier.scan(store.id, data);
      if (value == null) {
        displayToastWithContext(TypeMsg.error, "QR Code déjà utilisé");
        barcodeNotifier.clearBarcode();
        ongoingTransactionNotifier.clearOngoingTransaction();
        return;
      } else {
        setState(() {
          scannedValue = barcodes.barcodes.firstOrNull?.rawValue;
        });
        ongoingTransactionNotifier.updateOngoingTransaction(value);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _subscription = controller.barcodes.listen(_handleBarcode);
    unawaited(() async {
      await controller.start();
      if (!controller.value.hasCameraPermission && mounted) {
        showDialog(
          context: context,
          builder: (context) => CustomDialogBox(
            title: 'Permission caméra requise',
            descriptions:
                'Pour scanner des QR codes, l\'application a besoin d\'accéder à votre caméra. Veuillez accorder cette permission dans les paramètres de votre appareil.',
            onYes: () async {
              Navigator.of(context).pop();
              await openAppSettings();
            },
            yesText: 'Paramètres',
          ),
        );
      }
    }());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller.value.availableCameras == 0) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);
        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = MediaQuery.of(context).size.width * 0.8;
    final ongoingTransaction = ref.watch(ongoingTransactionProvider);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      child: Container(
        color: Colors.black,
        child: scannedValue != null
            ? Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: QrImageView(
                      data: scannedValue!,
                      version: QrVersions.auto,
                      size: MediaQuery.of(context).size.width * 0.8,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  CustomPaint(
                    size: Size.infinite,
                    painter: ScannerOverlayPainter(
                      scanArea: MediaQuery.of(context).size.width * 0.8,
                      borderColor: ongoingTransaction.when(
                        data: (_) => Color(0xff387200),
                        error: (_, _) => Color(0xff720000),
                        loading: () => Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            : MobileScanner(
                controller: controller,
                overlayBuilder: (context, constraints) {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: ScannerOverlayPainter(
                      scanArea: scanArea,
                      borderColor: ongoingTransaction.when(
                        data: (_) => Color(0xff387200),
                        error: (_, _) => Color(0xff720000),
                        loading: () => Colors.white,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    await controller.dispose();
  }
}
