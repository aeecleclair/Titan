import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/others/tools/constants.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              HeroIcon(
                HeroIcons.bellAlert,
                size: 100,
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  OthersTextConstants.tooOldVersion,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
