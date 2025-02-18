import 'package:flutter/material.dart';
import 'package:myecl/paiement/ui/pages/qr_page/qr_code.dart';
import 'package:myecl/paiement/ui/paiement.dart';

class QrPage extends StatelessWidget {
  const QrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PaymentTemplate(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Center(
          child: QrCode(),
        ),
        Spacer(
          flex: 2,
        ),
      ],
    ),);
  }
}
