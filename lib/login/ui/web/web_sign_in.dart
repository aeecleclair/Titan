import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myecl/login/ui/web/left_panel.dart';
import 'package:myecl/login/ui/web/right_panel.dart';
import 'package:myecl/login/ui/web/title_bar.dart';

class WebSignIn extends StatelessWidget {
  const WebSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/web/back.webp'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListView(
              children: [
                if (MediaQuery.sizeOf(context).width > 750)
                  Row(children: [
                    SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width / 2,
                        child: const LeftPanel()),
                    SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width / 2,
                        child: const RightPanel()),
                  ])
                else
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const TitleBar(),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 4 / 5,
                          width: MediaQuery.sizeOf(context).width,
                          child: const LeftPanel()),
                    ],
                  ),
              ],
            ),
            if (MediaQuery.sizeOf(context).width > 750)
              Positioned(
                  top: 20,
                  left: 30,
                  child: SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2,
                      child: const TitleBar())),
          ],
        ),
      ),
    );
  }
}
