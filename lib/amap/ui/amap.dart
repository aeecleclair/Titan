import 'package:flutter/material.dart';
import 'package:myecl/amap/ui/top_bar.dart';

class AmapTemplate extends StatelessWidget {
  final Widget child;
  const AmapTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              const TopBar(),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
