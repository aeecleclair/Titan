import 'package:flutter/material.dart';
import 'package:titan/booking/router.dart';
import 'package:titan/booking/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class BookingTemplate extends StatelessWidget {
  final Widget child;
  const BookingTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const TopBar(
            title: BookingTextConstants.booking,
            root: BookingRouter.root,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
