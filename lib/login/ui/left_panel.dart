import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeftPanel extends StatelessWidget {
  const LeftPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 160,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/logo.png',
                            width: 70, height: 70),
                        SizedBox(width: 20),
                        Text('MyEcl',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        SizedBox(width: 15),
                        Text("-",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black)),
                        SizedBox(width: 15),
                        Text("L'application de l'associatif centralien",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),

                      ],
                    ),
                  ),
                ),
                Spacer(flex: 1)
              ],
            )),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              SvgPicture.asset('assets/images/login.svg',
                  width: 350, height: 350),
              SizedBox(height: 70),
              Container(
                width: 400,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFF8A14),
                      Color.fromARGB(255, 255, 114, 0)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 114, 0).withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                    child: Text('Login',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
              ),
              Spacer(flex: 3),
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Spacer(),
                    Text('Forgot password?',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Color.fromARGB(255, 48, 48, 48))),
                    Spacer(flex: 4),
                    Text('Create an account',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Color.fromARGB(255, 48, 48, 48))),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        )
      ],
    );
  }
}
