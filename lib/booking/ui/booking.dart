import 'package:flutter/material.dart';
import 'package:myecl/booking/router.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/tools/ui/top_bar.dart';

class BookingTemplate extends StatelessWidget {
  final Widget child;
  const BookingTemplate({Key? key, required this.child}) : super(key: key);

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
          Expanded(child: child)
        ],
      ),
    );
  }
}
