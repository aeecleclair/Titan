import 'package:flutter/material.dart';

class GameScore extends StatelessWidget {
  const GameScore({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _TextWidget(title: 'S C O R E', number: 0.toString()),
        _TextWidget(title: 'R E C O R D', number: 0.toString())
      ],
    );
  }
}


class _TextWidget extends StatelessWidget {
  const _TextWidget({
    Key? key,
    required this.title,
    required this.number,
  }) : super(key: key);

  final String title;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(number, style: const TextStyle(color: Colors.white, fontSize: 25)),
        const SizedBox(
          height: 15,
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }
}