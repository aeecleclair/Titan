import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/constants.dart';

class Waiter extends StatelessWidget {
  final Color color;
  const Waiter({super.key, this.color = AMAPColorConstants.greenGradient2});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: color));
  }
}
