import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final Color? color;
  const Loader({super.key, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.hasBoundedWidth && constraints.hasBoundedHeight
            ? constraints.biggest.shortestSide
            : 24.0;

        return Center(
          child: SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(color: color),
          ),
        );
      },
    );
  }
}
