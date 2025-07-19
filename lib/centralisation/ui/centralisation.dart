import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';

class CentralisationTemplate extends StatelessWidget {
  final Widget child;
  const CentralisationTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(color: ColorConstants.background, child: child);
  }
}
