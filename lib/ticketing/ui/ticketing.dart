import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/ticketing/router.dart';
import 'package:titan/ticketing/tools/constants.dart';

class TicketingTemplate extends StatelessWidget {
  final Widget child;
  const TicketingTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TopBar(
            title: TicketingTextConstants.ticketing,
            root: TicketingRouter.root,
            rightIcon: QR.currentPath == TicketingRouter.root
                ? IconButton(
                    onPressed: () {
                      QR.to(TicketingRouter.root);
                    },
                    icon: const HeroIcon(
                      HeroIcons.informationCircle,
                      color: Colors.black,
                      size: 40,
                    ),
                  )
                : null,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
