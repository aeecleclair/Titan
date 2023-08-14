import 'package:flutter/material.dart';
import 'package:myecl/advert/ui/router.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/tools/ui/top_bar.dart';

class AdvertTemplate extends StatelessWidget {
  final Widget child;
  const AdvertTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [const TopBar(
              title: AdvertTextConstants.advert,
              root: AdvertRouter.root,
            ), 
            const SizedBox(height: 30,),            
            Expanded(child: child)],
          ),
        ),
      ),
    );
  }
}