import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myecl/purchases/class/generated_ticket.dart';
import 'package:myecl/purchases/class/ticket_information.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({
    super.key,
    required this.generatedTicket,
    required this.onScan,
    required this.scanner,
  });

  final GeneratedTicket generatedTicket;
  final Function onScan;
  final AsyncValue<TicketInformation> scanner;

  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
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
                color:  widget.scanner.when(
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
        setState(() {
          qrCode = capture.barcodes.first.rawValue;
        });
        widget.onScan(qrCode!);
      },
    );
  }
}


