import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:titan/purchases/class/ticket.dart';

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

class QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  String? qrCode;

  final MobileScannerController controller = MobileScannerController();

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
      onDetect: (BarcodeCapture capture) async {
        final rawValue = capture.barcodes.firstOrNull?.rawValue;
        setState(() {
          qrCode = rawValue;
        });
        if (rawValue != null) {
          widget.onScan(rawValue);
        }
      },
    );
  }
}
