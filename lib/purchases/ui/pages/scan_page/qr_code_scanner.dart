import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:titan/purchases/class/ticket.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({
    super.key,
    required this.onScan,
    required this.scanner,
  });

  final Function(String) onScan;
  final AsyncValue<Ticket> scanner;

  @override
  QRCodeScannerScreenState createState() => QRCodeScannerScreenState();
}

class QRCodeScannerScreenState extends State<QRCodeScannerScreen>
    with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(
    autoStart: false,
  );

  StreamSubscription<Object?>? _subscription;
  DateTime? _lastTimeScanned;

  static const _scanCooldown = Duration(seconds: 5);

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

  void _handleBarcode(BarcodeCapture capture) {
    final now = DateTime.now();
    if (_lastTimeScanned != null &&
        now.difference(_lastTimeScanned!) < _scanCooldown) {
      return;
    }

    final rawValue = capture.barcodes.firstOrNull?.rawValue;
    if (rawValue == null) {
      return;
    }

    _lastTimeScanned = now;
    widget.onScan(rawValue);
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
    return MobileScanner(
      controller: controller,
      overlayBuilder: (context, constraints) {
        return Center(
          child: Container(
            width: constraints.maxWidth * 0.8,
            height: constraints.maxWidth * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: widget.scanner.when(
                  data: (data) => Colors.green,
                  loading: () => Colors.white,
                  error: (error, stackTrace) => Colors.red,
                ),
                width: 2,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    unawaited(controller.dispose());
    super.dispose();
  }
}
