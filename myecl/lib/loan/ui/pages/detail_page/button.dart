import 'package:flutter/cupertino.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/loan/tools/constants.dart';

class LoanButton extends StatelessWidget {
  final Function onPressed;
  final HeroIcons icon;

  const LoanButton({Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  LoanColorConstants.orange,
                  LoanColorConstants.lightOrange,
                  LoanColorConstants.orange,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: LoanColorConstants.orange.withOpacity(0.2),
                    offset: const Offset(2, 3),
                    blurRadius: 10,
                    spreadRadius: 3)
              ]),
          child: HeroIcon(
            icon,
            size: 30,
            color: LoanColorConstants.lightGrey,
          )),
    );
  }
}
