import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';

class VoteTemplate extends StatelessWidget {
  final Widget child;
  const VoteTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(color: ColorConstants.background, child: child);
  }
}
