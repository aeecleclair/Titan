import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 50,
        stiffness: 500,
        damping: 1,
      );
}

class CMMList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView(
        physics: CustomPageViewScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: []);
  }
}
