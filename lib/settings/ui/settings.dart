import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/drawer/ui/app_template.dart';
import 'package:myecl/settings/ui/top_bar.dart';

class SettingsTemplate extends ConsumerWidget {
  final Widget child;
  // final AnimationController controller;
  const SettingsTemplate(
      {Key? key,
      // required this.controller,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppTemplate(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SafeArea(
            child: IgnorePointer(
              // ignoring: controller.isCompleted
              ignoring: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const TopBar(),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
