import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/tricount/class/equilibrium_transaction.dart';

class EquilibriumCard extends StatelessWidget {
  final EquilibriumTransaction equilibriumTransaction;
  const EquilibriumCard({super.key, required this.equilibriumTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.red,
                child: Text(
                  equilibriumTransaction.from.nickname != null
                      ? equilibriumTransaction.from.nickname!.substring(0, 3)
                      : equilibriumTransaction.from.firstname.substring(0, 3),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 10),
              const HeroIcon(
                HeroIcons.arrowRight,
                color: Colors.grey,
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.red,
                child: Text(
                  equilibriumTransaction.to.nickname != null
                      ? equilibriumTransaction.to.nickname!.substring(0, 3)
                      : equilibriumTransaction.to.firstname.substring(0, 3),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Text(
                "${equilibriumTransaction.amount.toStringAsFixed(2)}€",
                style: const TextStyle(
                    color: Color(0xff1C4668),
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
