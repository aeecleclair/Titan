// From https://github.com/juliansteenbakker/mobile_scanner/blob/master/example/lib/barcode_scanner_controller.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myecl/paiement/providers/barcode_provider.dart';
import 'package:myecl/paiement/providers/scan_provider.dart';
import 'package:myecl/paiement/providers/store_provider.dart';
import 'package:myecl/paiement/ui/pages/scan_page/scan_overlay_shape.dart';

class Scanner extends ConsumerStatefulWidget {
  const Scanner({super.key});

  @override
  ConsumerState<Scanner> createState() => _Scanner();
}

class _Scanner extends ConsumerState<Scanner> with WidgetsBindingObserver {
  final controller = MobileScannerController(
    autoStart: false,
  );

  StreamSubscription<Object?>? _subscription;

  void _handleBarcode(BarcodeCapture barcodes) {
    final barcodeNotifier = ref.read(barcodeProvider.notifier);
    final store = ref.read(storeProvider);
    final scanNotifier = ref.read(scanProvider.notifier);
    if (mounted && barcodes.barcodes.isNotEmpty) {
      final data = barcodeNotifier
          .updateBarcode(barcodes.barcodes.firstOrNull!.rawValue!);
      scanNotifier.scan(store.id, data);
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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      child: MobileScanner(
        controller: controller,
        overlayBuilder: (context, constraints) {
          return Center(
            child: Container(
              decoration: ShapeDecoration(
                shape: QrScannerOverlayShape(
                  borderColor: Colors.white,
                  borderRadius: 10,
                  borderLength: 40,
                  borderWidth: 7,
                  cutOutSize: scanArea,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await controller.dispose();
  }
}
