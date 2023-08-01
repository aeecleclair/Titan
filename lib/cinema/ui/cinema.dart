import 'package:flutter/material.dart';
import 'package:myecl/cinema/router.dart';
import 'package:myecl/cinema/ui/top_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CinemaTemplate extends StatelessWidget {
  final Widget child;
  const CinemaTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (QR.currentPath != CinemaRouter.root + CinemaRouter.detail)
          ? SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [const TopBar(), Expanded(child: child)],
              ),
            )
          : child,
    );
  }
}
