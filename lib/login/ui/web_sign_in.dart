import 'package:flutter/material.dart';
import 'package:myecl/login/ui/left_panel.dart';
import 'package:myecl/login/ui/right_panel.dart';

class WebSignIn extends StatelessWidget {
  const WebSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/back.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Row(children: [
              Expanded(child: LeftPanel()),
              Expanded(child: RightPanel()),
            ]),
          ],
        ),
      ),
    );
  }
}
