import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/sdec/router.dart';
import 'package:myecl/sdec/tools/constants.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SDeCTemplate extends StatelessWidget {
  final Widget child;
  const SDeCTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TopBar(
                title: SDeCTextConstants.sdecnom,
                root: SdecRouter.root,
                rightIcon: QR.currentPath == SdecRouter.root
                    ? IconButton(
                        onPressed: () {
                          QR.to(SdecRouter.root + SdecRouter.presentation);
                        },
                        icon: const HeroIcon(
                          HeroIcons.informationCircle,
                          color: Colors.black,
                          size: 40,
                        ))
                    : null,
              ),
              Expanded(child: child)
            ],
          ),
        ),
      ),
    );
  }
}
