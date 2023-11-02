import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tricount/class/equilibrium_transaction.dart';
import 'package:myecl/tricount/tools/functions.dart';

class EquilibriumCard extends StatelessWidget {
  final EquilibriumTransaction equilibriumTransaction;
  const EquilibriumCard({super.key, required this.equilibriumTransaction});

  @override
  Widget build(BuildContext context) {
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
                  getAvatarName(equilibriumTransaction.from),
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
                  getAvatarName(equilibriumTransaction.to),
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
