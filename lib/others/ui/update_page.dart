
import 'package:flutter/material.dart';
import 'package:myecl/others/tools/constants.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        OthersTextConstants.tooOldVersion,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 158, 158, 158),
        ),
      ),
    );
  }
}
