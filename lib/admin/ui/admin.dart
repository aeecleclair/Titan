import 'package:flutter/material.dart';
import 'package:myecl/admin/ui/top_bar.dart';

class AdminTemplate extends StatelessWidget {
  final Widget child;
  const AdminTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [const TopBar(), Expanded(child: child)],
          ),
        ),
      ),
    );
  }
}
