// From https://github.com/huextrat/numeric_keyboard/blob/master/lib/numeric_keyboard.dart

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/mypayment/tools/constants.dart';

class NumericKeyboard extends StatelessWidget {
  /// Color of the text [default = Colors.black]
  final Color textColor;

  /// Action to trigger when right button is pressed
  final Function()? rightButtonFn;

  /// Display a custom left icon
  final Icon? leftIcon;

  /// Action to trigger when left button is pressed
  final Function()? leftButtonFn;

  /// Callback when an item is pressed
  final Function(String) onKeyboardTap;

  /// Main axis alignment [default = .spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;

  const NumericKeyboard({
    super.key,
    required this.onKeyboardTap,
    this.textColor = MyPaymentColors.onGradient,
    this.rightButtonFn,
    this.leftIcon,
    this.leftButtonFn,
    this.mainAxisAlignment = .spaceEvenly,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .only(left: 32, right: 32, top: 20),
      alignment: .center,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: .spaceBetween,
            children: <Widget>[
              _calcButton('1'),
              _calcButton('2'),
              _calcButton('3'),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: <Widget>[
              _calcButton('4'),
              _calcButton('5'),
              _calcButton('6'),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: <Widget>[
              _calcButton('7'),
              _calcButton('8'),
              _calcButton('9'),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: <Widget>[
              _calcButton(','),
              _calcButton('0'),
              GestureDetector(
                onTap: rightButtonFn,
                child: Container(
                  alignment: .center,
                  width: 50,
                  height: 50,
                  child: HeroIcon(.backspace, color: textColor, size: 35),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _calcButton(String value) {
    return InkWell(
      borderRadius: .circular(45),
      onTap: () {
        onKeyboardTap(value);
      },
      child: Container(
        alignment: .center,
        width: 50,
        height: 50,
        child: Text(value, style: TextStyle(fontSize: 26, color: textColor)),
      ),
    );
  }
}
