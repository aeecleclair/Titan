import 'package:flutter/material.dart';
import 'package:titan/loan/tools/constants.dart';
import 'package:numberpicker/numberpicker.dart';

class DelayDialog extends StatefulWidget {
  final void Function(int i) onYes;
  const DelayDialog({super.key, required this.onYes});

  @override
  IntegerExampleState createState() => IntegerExampleState();
}

class IntegerExampleState extends State<DelayDialog> {
  int _currentIntValue = 5;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade700,
                offset: const Offset(0, 5),
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                LoanTextConstants.delay,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              NumberPicker(
                value: _currentIntValue,
                minValue: 1,
                maxValue: 100,
                step: 1,
                haptics: true,
                onChanged: (value) => setState(() => _currentIntValue = value),
              ),
              const SizedBox(height: 22),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        LoanTextConstants.cancel,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onYes(_currentIntValue);
                      },
                      child: const Text(
                        LoanTextConstants.confirm,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
