import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class QRCodeScannerScreen extends StatelessWidget {
  const QRCodeScannerScreen({
    super.key,
    required this.onScan,
    required this.scanner,
  });

  final Function onScan;
  final AsyncValue<Ticket> scanner;

  @override
  Widget build(BuildContext context) {
    final MobileScannerController controller = MobileScannerController();
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
                color: scanner.when(
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
      onDetect: (BarcodeCapture capture) async {
        onScan(capture.barcodes.first.rawValue!);
      },
    );
  }
}
