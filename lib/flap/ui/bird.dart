import 'package:flutter/cupertino.dart';

class Bird extends StatelessWidget {
  const Bird({
    Key? key,
    required this.birdSize,
  }) : super(key: key);

  final double birdSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image.asset('assets/images/bird_2.png'),
      width: birdSize,
      height: birdSize,
    );
  }
}
