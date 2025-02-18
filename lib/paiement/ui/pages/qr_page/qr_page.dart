import 'package:flutter/material.dart';
import 'package:myecl/paiement/ui/pages/qr_page/qr_code.dart';

class QrPage extends StatelessWidget {
  const QrPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Spacer(),
        Center(
          child: QrCode(),
        ),
        Spacer(
          flex: 2,
        ),
      ],
    ));
  }
}
