import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  bool cameraPaused = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      if (Platform.isAndroid) {
        controller!.pauseCamera();
      }
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          _buildQrView(context),
          Column(
            children: <Widget>[
              const Spacer(),
              Container(
                height: MediaQuery.of(context).size.height - 670,
                color: Colors.black.withOpacity(0.48),
              ),
            ],
          ),
          Column(children: <Widget>[
            const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height - 600,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                      onTap: () async {
                        await controller?.toggleFlash();
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: FutureBuilder(
                          future: controller?.getFlashStatus(),
                          builder: (context, snapshot) {
                            return HeroIcon(
                                snapshot.data == true
                                    ? HeroIcons.boltSlash
                                    : HeroIcons.bolt,
                                color: Colors.black,
                                size: 50);
                          },
                        ),
                      )),
                  GestureDetector(
                      onTap: () async {
                        if (cameraPaused == true) {
                          await controller?.resumeCamera();
                          setState(() {
                            cameraPaused = false;
                          });
                        } else {
                          await controller?.pauseCamera();
                          setState(() {
                            cameraPaused = true;
                          });
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: HeroIcon(
                            cameraPaused ? HeroIcons.play : HeroIcons.pause,
                            color: Colors.black,
                            size: 50,
                          ))),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 350 ||
            MediaQuery.of(context).size.height < 350)
        ? 250.0
        : 320.0;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlayMargin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - scanArea - 350),
        overlay: QrScannerOverlayShape(
            borderColor: const Color(0xff017f80),
            borderRadius: 20,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
