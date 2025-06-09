import 'package:flutter/material.dart';
import 'package:myemapp/settings/router.dart';
import 'package:myemapp/settings/tools/constants.dart';
import 'package:myemapp/tools/ui/widgets/top_bar.dart';

class SettingsTemplate extends StatelessWidget {
  final Widget child;
  const SettingsTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TopBar(
              title: SettingsTextConstants.settings,
              root: SettingsRouter.root,
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
