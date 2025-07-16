import 'package:flutter/material.dart';
import 'package:titan/navigation/ui/top_bar.dart';
import 'package:titan/tools/constants.dart';

class AdminTemplate extends StatelessWidget {
  final Widget child;
  const AdminTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TopBar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
