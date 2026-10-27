import 'package:flutter/material.dart';
import 'package:titan/raffle/tools/constants.dart';

class BlueBtn extends StatelessWidget {
  final Widget child;

  const BlueBtn({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            RaffleColorConstants.gradient1,
            RaffleColorConstants.gradient2,
          ],
          begin: .topLeft,
          end: .bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: RaffleColorConstants.gradient2.withValues(alpha: 0.4),
            offset: const Offset(2, 3),
            blurRadius: 5,
          ),
        ],
        borderRadius: const .all(Radius.circular(15)),
      ),
      child: Container(
        alignment: .center,
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: .all(Radius.circular(13)),
          color: Colors.white,
        ),
        child: child,
      ),
    );
  }
}
