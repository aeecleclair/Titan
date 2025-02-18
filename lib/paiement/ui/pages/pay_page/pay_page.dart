import 'package:flutter/material.dart';
import 'package:myecl/paiement/ui/pages/pay_page/keyboard.dart';
// import 'package:myecl/paiement/ui/pages/pay_page/qrcode.dart';

class PayPage extends StatelessWidget {
  const PayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumericKeyboard(
      onKeyboardTap: (_) {},
    );
  }
}
