import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        const CircleAvatar(
          radius: 27,
          backgroundColor: Color(0xff017f80),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              AutoSizeText("Maxime Roucher (Khurzs)",
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(0xff204550),
                    fontSize: 14,
                  )),
              SizedBox(
                height: 5,
              ),
              Text("12/10/2021",
                  style: TextStyle(
                    color: Color(0xff204550),
                    fontSize: 12,
                  )),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const Text("- 2,50€",
            style: TextStyle(
                color: Color(0xff204550),
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ]),
    );
  }
}
