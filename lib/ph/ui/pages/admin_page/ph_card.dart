import 'package:flutter/material.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';

class PhCard extends StatelessWidget {
  final Ph ph;
  const PhCard({
    super.key,
    required this.ph,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CardLayout(
        child: Text(ph.name),
      ),
    );
  }
}
