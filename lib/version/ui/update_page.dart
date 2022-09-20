import 'package:flutter/cupertino.dart';
import 'package:myecl/version/tools/constants.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      VersionTextConstants.tooOldVersion,
      style: TextStyle(fontSize: 20),
    );
  }
}
