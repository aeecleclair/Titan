import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/ui/background_anim.dart';
import 'package:myecl/elocaps/ui/elocaps.dart';

class EloCapsMainPage extends HookConsumerWidget {
  const EloCapsMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animation = useAnimationController(
        duration: const Duration(milliseconds: 3000), initialValue: 0)
      ..repeat(reverse: true);
      
    return ElocapsTemplate(
        child: Column(
      children: [Expanded(child:CustomPaint(painter: MyCustomPainter(animation: animation)))],
    ));
  }
}
