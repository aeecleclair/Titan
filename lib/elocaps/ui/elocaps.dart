import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/elocaps/router.dart';
import 'package:myecl/elocaps/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';

class ElocapsTemplate extends HookConsumerWidget {
  final Widget child;
  const ElocapsTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              const TopBar(
                title: ElocapsTextConstant.elocaps,
                root: ElocapsRouter.root,
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
