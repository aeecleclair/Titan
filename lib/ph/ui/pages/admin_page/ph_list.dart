import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';

class PhList extends HookConsumerWidget {
  final Ph ph;
  const PhList({
    super.key,
    required this.ph,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column();
  }
}
