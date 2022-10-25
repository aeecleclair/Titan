import 'package:flutter/material.dart';
import 'package:myecl/home/tools/constants.dart';

class DayCard extends StatelessWidget {
  final bool isSelected;
  const DayCard({super.key, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin:
          const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isSelected
              ? [
                  HomeColorConstants.gradient1,
                  HomeColorConstants.gradient2,
                ]
              : [
                  Colors.grey.shade100,
                  Colors.grey.shade200,
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? HomeColorConstants.gradient2.withOpacity(0.2)
                : Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      height: 100,
      width: 70,
      child: Column(
        children: [
          Container(
            height: 20,
          ),
          SizedBox(
            height: 35,
            child: Text(
              '10',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          // L'heure de début et de fin de la mission
          SizedBox(
            height: 15,
            child: Text(
              'Lun',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
