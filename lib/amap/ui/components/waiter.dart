import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/constants.dart';

class Waiter extends StatelessWidget {
  const Waiter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: AMAPColorConstants.greenGradient2,
    ));
  }
}
