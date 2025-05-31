// From https://github.com/juliansteenbakker/mobile_scanner/blob/master/example/lib/barcode_scanner_controller.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myecl/paiement/providers/barcode_provider.dart';
import 'package:myecl/paiement/providers/bypass_provider.dart';
import 'package:myecl/paiement/providers/last_time_scanned.dart';
import 'package:myecl/paiement/providers/ongoing_transaction.dart';
import 'package:myecl/paiement/providers/scan_provider.dart';
import 'package:myecl/paiement/providers/selected_store_provider.dart';
import 'package:myecl/paiement/ui/pages/scan_page/scan_overlay_shape.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/widgets/custom_dialog_box.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScannerOverlayPainter extends CustomPainter {
  final double scanArea;
  final Color borderColor;
  final double borderWidth;
  final double borderLength;
  final double borderRadius;

  ScannerOverlayPainter({
    required this.scanArea,
    required this.borderColor,
    this.borderWidth = 7,
    this.borderLength = 70,
    this.borderRadius = 1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    // Définition du cutout rect (zone de scan)
    final cutOutRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: scanArea,
      height: scanArea,
    );

    // Créer le masque avec une "fenêtre" transparente
    final overlay = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(
        RRect.fromRectAndRadius(cutOutRect, Radius.circular(borderRadius)),
      )
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(overlay, paint);

    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Coins (4 lignes par coin)
    final left = cutOutRect.left;
    final top = cutOutRect.top;
    final right = cutOutRect.right;
    final bottom = cutOutRect.bottom;

    // Haut gauche
    canvas.drawLine(
      Offset(left, top + borderLength),
      Offset(left, top),
      borderPaint,
    );
    canvas.drawLine(
      Offset(left, top),
      Offset(left + borderLength, top),
      borderPaint,
    );

    // Haut droite
    canvas.drawLine(
      Offset(right, top + borderLength),
      Offset(right, top),
      borderPaint,
    );
    canvas.drawLine(
      Offset(right, top),
      Offset(right - borderLength, top),
      borderPaint,
    );

    // Bas gauche
    canvas.drawLine(
      Offset(left, bottom - borderLength),
      Offset(left, bottom),
      borderPaint,
    );
    canvas.drawLine(
      Offset(left, bottom),
      Offset(left + borderLength, bottom),
      borderPaint,
    );

    // Bas droite
    canvas.drawLine(
      Offset(right, bottom - borderLength),
      Offset(right, bottom),
      borderPaint,
    );
    canvas.drawLine(
      Offset(right, bottom),
      Offset(right - borderLength, bottom),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

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
    unawaited(controller.start());
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
                  QrImageView(
                    data: scannedValue!,
                    version: QrVersions.auto,
                    size: MediaQuery.of(context).size.width * 0.8,
                    backgroundColor: Colors.white,
                  ),
                  Container(
                    decoration: ShapeDecoration(
                      shape: QrScannerOverlayShape(
                        borderColor: Colors.red,
                        borderRadius: 1,
                        borderLength: 40,
                        borderWidth: 7,
                        cutOutSize: MediaQuery.of(context).size.width * 0.8,
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
                        data: (_) => Colors.green,
                        error: (_, __) => Colors.red,
                        loading: () => Colors.white,
                      ),
                      borderWidth: 5,
                      borderLength: 40,
                      borderRadius: 10,
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
