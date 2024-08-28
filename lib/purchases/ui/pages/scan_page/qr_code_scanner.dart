import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myecl/purchases/class/product.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({
    super.key,
    required this.product,
    required this.onScan,
  });

  final Product product;
  final Function onScan;

  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  String? qrCode;

  final MobileScannerController controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: MobileScanner(
      controller: controller,
      onDetect: (BarcodeCapture capture) async {
        setState(() {
          qrCode = capture.raw.toString();
        });
        print(qrCode);
        //widget.onScan(qrCode!);
      },
    ));
  }
}
