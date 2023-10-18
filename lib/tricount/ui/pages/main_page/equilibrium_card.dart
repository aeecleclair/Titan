import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tricount/class/equilibrium_transaction.dart';

class EquilibriumCard extends StatelessWidget {
  final EquilibriumTransaction equilibriumTransaction;
  const EquilibriumCard({super.key, required this.equilibriumTransaction});

  @override
  Widget build(BuildContext context) {
    final fromName = equilibriumTransaction.from.nickname != null
        ? equilibriumTransaction.from.nickname!
            .substring(0, min(equilibriumTransaction.from.nickname!.length, 3))
        : equilibriumTransaction.from.firstname
            .substring(0, min(equilibriumTransaction.from.firstname.length, 3));
    final toName = equilibriumTransaction.to.nickname != null
        ? equilibriumTransaction.to.nickname!
            .substring(0, min(equilibriumTransaction.to.nickname!.length, 3))
        : equilibriumTransaction.to.firstname
            .substring(0, min(equilibriumTransaction.to.firstname.length, 3));
    return Container(
      height: 65,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Text(
                  fromName,
                  style: const TextStyle(
                      color: Color(0xff09263D),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 10),
              HeroIcon(
                HeroIcons.arrowRight,
                color: Colors.grey.shade200,
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Text(
                  toName,
                  style: const TextStyle(
                      color: Color(0xff1C4668),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Text(
                "${equilibriumTransaction.amount.toStringAsFixed(2)}€",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
