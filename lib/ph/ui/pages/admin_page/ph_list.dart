import 'package:flutter/material.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class PhList extends StatelessWidget {
  final Ph ph;
  const PhList({
    super.key,
    required this.ph,
  });

  @override
  Widget build(BuildContext context) {
    return AsyncChild(value: ph, builder: (context, data))
  }
}
