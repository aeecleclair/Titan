import 'package:flutter/material.dart';
import 'package:myecl/home/ui/bottom_bar.dart';
import 'package:myecl/home/ui/fake_page.dart';
import 'package:myecl/home/ui/list_module.dart';
import 'package:myecl/home/ui/top_bar.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color(0xFF2F86C1),
              Color(0xFF1E557A)
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TopBar(),
            Row(
            children: [
              Expanded(
                  child: SizedBox(
                width: 200,
                height: MediaQuery.of(context).size.height * 4.5 / 10,
                child: const ListModule()
                )
              ),
              const FakePage(),
            ],
            ),
            const BottomBar(),
          ],
        ),
      ),
    );
  }
}
