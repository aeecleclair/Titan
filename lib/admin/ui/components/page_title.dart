import 'package:flutter/material.dart';
import 'package:myecl/tools/constants.dart';

class PageTitle extends StatelessWidget {
  final String title;
  const PageTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: ColorConstants.gradient1)),
    );
  }
}
