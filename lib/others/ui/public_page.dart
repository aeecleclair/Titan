import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class PublicPage extends StatelessWidget {
  const PublicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey.shade300, Colors.white],
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const Expanded(
                  child: HeroIcon(
                    HeroIcons.bolt,
                    size: 120,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFfb6d10),
                                  Color(0xffeb3e1b),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xffeb3e1b).withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      2, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: const Center(
                                child: Text("Se connecter",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))))),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text("Mot de passe oublié ?",
                            style: TextStyle(
                                color: Color(0xff2e2e41),
                                fontSize: 15,
                                fontWeight: FontWeight.bold))),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 214, 214, 214),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    )),
                    const SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFfb6d10),
                                  Color(0xffeb3e1b),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xffeb3e1b).withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      2, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                                child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Se créer un compte",
                                      style: TextStyle(
                                          color: Color(0xff2e2e41),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            )))),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text("Privacy Policy",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff2e2e41),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline))),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Terms of Service",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff2e2e41),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline)),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
